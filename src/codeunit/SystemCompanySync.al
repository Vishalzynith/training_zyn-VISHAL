codeunit 50100 Zync_CompanySync
{
    var Syncing: Boolean;

    //Inserting from Zyn_Company table to system company table
    [EventSubscriber(ObjectType::Table, Database::Company, 'OnAfterInsertEvent', '', true, true)]
    local procedure OnSystemCompanyInserted(var Rec: Record Company)
    var
        MyCompany: Record Zyn_Company;
    begin
        if Syncing then
            exit;
        Syncing := true;
        if not MyCompany.Get(Rec.Name) then begin
            MyCompany.Init();
            MyCompany.TransferFields(Rec);
            MyCompany.Insert();
        end;
        Syncing := false;
    end;

    //Modifying from Zyn_Company to system company table
    [EventSubscriber(ObjectType::Table, Database::Company, 'OnAfterModifyEvent', '', true, true)]
    procedure OnSystemCompanyModified(var Rec: Record Company)
    var
        MyCompany: Record Zyn_Company;
    begin
        if Syncing then
            exit;
        Syncing := true;
        if MyCompany.Get(Rec.Name) then begin
            if (MyCompany."Display Name" <> Rec."Display Name") or (MyCompany."Evaluation Company" <> Rec."Evaluation Company") then begin
                MyCompany."Display Name" := Rec."Display Name";
                MyCompany."Evaluation Company" := Rec."Evaluation Company";
                MyCompany.Modify();
            end;
        end;
        Syncing := false;
    end;

    //Deleting from Zyn_Company to system company table
    [EventSubscriber(ObjectType::Table, Database::Company, 'OnAfterDeleteEvent', '', true, true)]
    local procedure OnSystemCompanyDeleted(var Rec: Record Company)
    var
        MyCompany: Record Zyn_Company;
    begin
        if Syncing then
            exit;
        Syncing := true;
        if MyCompany.Get(Rec.Name) then
            MyCompany.Delete();
        Syncing := false;
    end;

    //Inserting from system company table to Zyn_Company
    [EventSubscriber(ObjectType::Table, Database::Zyn_Company, 'OnAfterInsertEvent', '', true, true)]
    local procedure OnMyCompanyInserted(var Rec: Record Zyn_Company)
    var
        SysCompany: Record Company;
    begin
        if Syncing then
            exit;
        Syncing := true;
        if not SysCompany.Get(Rec.Name) then begin
            SysCompany.Init();
            SysCompany.TransferFields(Rec);
            SysCompany.Insert();
        end;
        Syncing := false;
    end;

    //Modifying from system company table to Zyn_Company
    [EventSubscriber(ObjectType::Table, Database::Zyn_Company, 'OnAfterModifyEvent', '', true, true)]
    procedure OnMyCompanyModified(var Rec: Record Zyn_Company)
    var
        SysCompany: Record Company;
    begin
        if Syncing then
            exit;
        Syncing := true;
        if SysCompany.Get(Rec.Name) then begin
            if (SysCompany."Display Name" <> Rec."Display Name") or (SysCompany."Evaluation Company" <> Rec."Evaluation Company") then begin
                SysCompany."Display Name" := Rec."Display Name";
                SysCompany."Evaluation Company" := Rec."Evaluation Company";
                SysCompany.Modify();
            end;
        end;
        Syncing := false;
    end;

    //Deleting from system company table to Zyn_Company
    [EventSubscriber(ObjectType::Table, Database::Zyn_Company, 'OnAfterDeleteEvent', '', true, true)]
    local procedure OnMyCompanyDeleted(var Rec: Record Zyn_Company)
    var
        SysCompany: Record Company;
    begin
        if Syncing then
            exit;
        Syncing := true;
        if SysCompany.Get(Rec.Name) then
            SysCompany.Delete();
        Syncing := false;
    end;
}