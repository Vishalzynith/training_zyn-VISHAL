codeunit 50170 Zyn_CompanyContactSync
{
    var
        IsContactSyncing: Boolean;

    // Prevent creating contacts directly in slave companies
    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeInsertEvent', '', true, true)]
    local procedure PreventSlaveContactInsert(var Rec: Record Contact; RunTrigger: Boolean)
    var
        CompanyRecord: Record Zyn_Company;
    begin
        if not CompanyRecord.Get(COMPANYNAME) then
            Error(CompanyErr);

        if IsStandaloneCompany(CompanyRecord) then
            exit;

        if not CompanyRecord.IsMaster then
            Error(ContactCreationErr);
    end;

    // Contact creation in master company triggers sync to slaves
    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterInsertEvent', '', true, true)]
    local procedure OnMasterContactInserted(var Rec: Record Contact)
    begin
        SyncMasterContact(Rec);
    end;

    // Contact Modification Handling
    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterModifyEvent', '', true, true)]
    local procedure ContactOnAfterModify(var Rec: Record Contact; var xRec: Record Contact; RunTrigger: Boolean)
    var
        MasterCompany: Record Zyn_Company;
        SlaveCompany: Record Zyn_Company;
        SlaveContact: Record Contact;
        MasterRef: RecordRef;
        SlaveRef: RecordRef;
        Field: FieldRef;
        SlaveField: FieldRef;
        i: Integer;
        IsDifferent: Boolean;
    begin
        if IsContactSyncing then
            exit;

        if not MasterCompany.Get(COMPANYNAME) then
            exit;

        // If current company is master, replicate changes to all slaves
        if MasterCompany.IsMaster then begin
            SlaveCompany.SetRange(IsMaster, false);
            SlaveCompany.SetFilter(MasterCompanyName, '%1', MasterCompany.Name);

            if SlaveCompany.FindSet() then
                repeat
                    SlaveContact.ChangeCompany(SlaveCompany.Name);
                    if SlaveContact.Get(Rec."No.") then begin
                        MasterRef.GetTable(Rec);
                        SlaveRef.GetTable(SlaveContact);
                        IsDifferent := false;

                        for i := 1 to MasterRef.FieldCount do begin
                            Field := MasterRef.FieldIndex(i);
                            if Field.Class <> FieldClass::Normal then
                                continue;

                            // Skip primary key field "No."
                            if Field.Number in [1] then
                                continue;

                            SlaveField := SlaveRef.Field(Field.Number);
                            if SlaveField.Value <> Field.Value then begin
                                IsDifferent := true;
                                break;
                            end;
                        end;

                        if IsDifferent then begin
                            IsContactSyncing := true;
                            SlaveContact.TransferFields(Rec, false);
                            SlaveContact."No." := Rec."No.";
                            SlaveContact.Modify(true);
                            IsContactSyncing := false;
                        end;
                    end;
                until SlaveCompany.Next() = 0;
        end else begin

            // Blocking manual edits in slave companies
            if not MasterCompany.IsMaster and (MasterCompany.MasterCompanyName <> '') then begin

                // Allow system updates only
                if (UserId = '') or (UpperCase(UserId) = 'NT AUTHORITY\SYSTEM') then
                    exit;

                if not RunTrigger then
                    exit;

                Error(ContactModifyErr);
            end;
        end;
    end;

    // Contact deletion in master company triggers delete in slaves
    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterDeleteEvent', '', true, true)]
    local procedure OnMasterContactDeleted(var Rec: Record Contact)
    begin
        if IsContactSyncing then
            exit;

        if not IsMasterCompany() then
            exit;

        IsContactSyncing := true;
        SyncDeleteContactToSlaves(Rec);
        IsContactSyncing := false;
    end;

    // Prevent deleting contacts in master if used in slaves
    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeDeleteEvent', '', true, true)]
    local procedure ValidateBeforeMasterDelete(var Rec: Record Contact; RunTrigger: Boolean)
    begin
        if IsMasterCompany() then
            if not CanDeleteContactFromAllSlaves(Rec) then
                Error(ContactDeleteErr,Rec."No.");
    end;

    // Master~Slave Sync Logic for Insert
    local procedure SyncMasterContact(ContactRec: Record Contact)
    var
        CompanyRecord: Record Zyn_Company;
        SlaveCompany: Record Zyn_Company;
        ContactCopy: Record Contact;
    begin
        if IsContactSyncing then
            exit;

        if not CompanyRecord.Get(COMPANYNAME) then
            exit;

        if IsStandaloneCompany(CompanyRecord) or not IsMasterCompany() then
            exit;

        IsContactSyncing := true;

        SlaveCompany.SetRange(IsMaster, false);
        SlaveCompany.SetFilter(MasterCompanyName, '%1', CompanyRecord.Name);

        if SlaveCompany.FindSet() then
            repeat
                ContactCopy.ChangeCompany(SlaveCompany.Name);

                if not ContactCopy.Get(ContactRec."No.") then begin
                    ContactCopy.Init();
                    ContactCopy."No." := ContactRec."No.";
                    ContactCopy.TransferFields(ContactRec, true);
                    ContactCopy.Insert(true);
                end else begin
                    ContactCopy.Reset();
                    ContactCopy.Get(ContactRec."No.");
                    ContactCopy.TransferFields(ContactRec, true);
                    ContactCopy.Modify(true);
                end;
            until SlaveCompany.Next() = 0;

        IsContactSyncing := false;
    end;

    // Deletion Sync Logic with Contact Business Relation cleanup
    local procedure SyncDeleteContactToSlaves(ContactRec: Record Contact)
    var
        CompanyRecord: Record Zyn_Company;
        SlaveCompany: Record Zyn_Company;
        ContactCopy: Record Contact;
        Customer: Record Customer;
        Vendor: Record Vendor;
        ContactBusinessRelation: Record "Contact Business Relation";
    begin
        if not CompanyRecord.Get(COMPANYNAME) then
            exit;

        // Loop through all slave companies
        SlaveCompany.SetRange(IsMaster, false);
        SlaveCompany.SetFilter(MasterCompanyId, '%1', CompanyRecord.Id);

        if SlaveCompany.FindSet() then
            repeat
                ContactCopy.ChangeCompany(SlaveCompany.Name);
                Customer.ChangeCompany(SlaveCompany.Name);
                Vendor.ChangeCompany(SlaveCompany.Name);
                ContactBusinessRelation.ChangeCompany(SlaveCompany.Name);

                // Delete associate records in Contact Business Relation
                ContactBusinessRelation.Reset();
                ContactBusinessRelation.SetRange("Contact No.", ContactRec."No.");
                if ContactBusinessRelation.FindSet() then
                    repeat
                        case ContactBusinessRelation."Link to Table" of
                            ContactBusinessRelation."Link to Table"::Customer:
                                if Customer.Get(ContactBusinessRelation."No.") then
                                    Customer.Delete(true);

                            ContactBusinessRelation."Link to Table"::Vendor:
                                if Vendor.Get(ContactBusinessRelation."No.") then
                                    Vendor.Delete(true);
                        end;
                        ContactBusinessRelation.Delete();
                    until ContactBusinessRelation.Next() = 0;

                // Delete Contact itself in slave
                if ContactCopy.Get(ContactRec."No.") then
                    ContactCopy.Delete(true);

            until SlaveCompany.Next() = 0;
    end;

    // Delete Sync Validation Logic
    local procedure CanDeleteContactFromAllSlaves(ContactRec: Record Contact): Boolean
    var
        CompanyRecord: Record Zyn_Company;
        SlaveCompany: Record Zyn_Company;
        SalesHeader: Record "Sales Header";
        PurchaseHeader: Record "Purchase Header";
    begin
        if not CompanyRecord.Get(COMPANYNAME) then
            exit(false);

        if IsStandaloneCompany(CompanyRecord) then
            exit(true);

        SlaveCompany.SetRange(IsMaster, false);
        SlaveCompany.SetFilter(MasterCompanyName, '%1', CompanyRecord.Name);

        if SlaveCompany.FindSet() then
            repeat
                SalesHeader.ChangeCompany(SlaveCompany.Name);
                PurchaseHeader.ChangeCompany(SlaveCompany.Name);

                SalesHeader.SetRange("Bill-to Contact No.", ContactRec."No.");
                SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                SalesHeader.SetFilter(Status, '%1|%2', SalesHeader.Status::Open, SalesHeader.Status::Released);
                if SalesHeader.FindFirst() then
                    exit(false);

                PurchaseHeader.SetRange("Buy-from Vendor No.", ContactRec."No.");
                PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Invoice);
                PurchaseHeader.SetFilter(Status, '%1|%2', PurchaseHeader.Status::Open, PurchaseHeader.Status::Released);
                if PurchaseHeader.FindFirst() then
                    exit(false);

            until SlaveCompany.Next() = 0;

        exit(true);
    end;

    // Master Company Check
    local procedure IsMasterCompany(): Boolean
    var
        CompanyRecord: Record Zyn_Company;
    begin
        if not CompanyRecord.Get(COMPANYNAME) then
            exit(false);

        exit(CompanyRecord.IsMaster);
    end;

    // Standalone Company Check
    local procedure IsStandaloneCompany(var CompanyRecord: Record Zyn_Company): Boolean
    begin
        exit(not CompanyRecord.IsMaster and (CompanyRecord.MasterCompanyName = ''));
    end;

    var 
    CompanyErr: Label 'Company not found.';
    ContactCreationErr: Label 'Contacts can only be created in the master company.';
    ContactModifyErr: Label 'Manual modification of contacts in not allowed in slave';
    ContactDeleteErr: Label 'Cannot delete contact %1: Open sales/purchase invoices exist in one or more slave companies.';
}
