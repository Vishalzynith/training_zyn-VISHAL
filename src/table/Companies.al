table 50188 Zyn_Company
{
    Caption = 'Company';
    DataPerCompany = false;
    Scope = Cloud;
    ReplicateData = false;

    fields
    {
        field(1; Name; Text[30])
        {
            Caption = 'Name';
            ToolTip = 'Specifies the company name. Cannot be changed after creation.';
            trigger OnValidate()
            begin
                if xRec.Name <> '' then
                    Error(NameErr);
            end;
        }

        field(2; "Evaluation Company"; Boolean)
        {
            Caption = 'Evaluation Company';
        }

        field(3; "Display Name"; Text[250])
        {
            Caption = 'Display Name';
        }

        field(10; IsMaster; Boolean)
        {
            Caption = 'Is Master Company';
            ToolTip = 'Indicates if this company is the master. Only one company can be master.';
            trigger OnValidate()
            var
                CompanyRec: Record Zyn_Company;
            begin
                if IsMaster then begin
                    // Ensure only one master exists
                    CompanyRec.Reset();
                    CompanyRec.SetRange(IsMaster, true);
                    if CompanyRec.FindFirst() and (CompanyRec.Name <> Rec.Name) then
                        Error('Only one company can be set as master.');

                    // Master cannot be slave
                    if not IsNullGuid(MasterCompanyId) then
                        Error('A master company cannot have another master.');

                    Clear(MasterCompanyId);
                    Clear(MasterCompanyName);
                end;
            end;
        }

        field(11; MasterCompanyId; Guid)
        {
            Caption = 'Master Company ID';
            ToolTip = 'If this company is a slave, specifies the master company.';
            trigger OnValidate()
            var
                MasterCompany: Record Zyn_Company;
            begin
                if not IsNullGuid(MasterCompanyId) then begin
                    if IsMaster then
                        Error('A master cannot also be a slave.');

                    if not MasterCompany.Get(MasterCompanyId) then
                        Error('Selected master company does not exist.');

                    if not MasterCompany.IsMaster then
                        Error('Selected company is not marked as master.');

                    // Sync Name automatically
                    MasterCompanyName := MasterCompany.Name;
                end else begin
                    // No master selected → standalone company
                    Clear(MasterCompanyName);
                end;
            end;
        }

        field(12; MasterCompanyName; Text[30])
        {
            Caption = 'Master Company Name';
            ToolTip = 'Name of the master company (for UI selection).';
            trigger OnValidate()
            var
                MasterCompany: Record Zyn_Company;
            begin
                if MasterCompanyName <> '' then begin
                    if not MasterCompany.Get(MasterCompanyName) then
                        Error('Selected master company does not exist.');

                    if not MasterCompany.IsMaster then
                        Error('Selected company is not marked as master.');

                    // Sync ID automatically
                    MasterCompanyId := MasterCompany.Id;
                end else begin
                    Clear(MasterCompanyId);
                end;
            end;
        }

        field(8000; Id; Guid)
        {
            Caption = 'Id';
            ToolTip = 'Unique identifier for the company.';
        }

        field(8005; "Business Profile Id"; Text[250])
        {
            Caption = 'Business Profile Id';
        }
    }

    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
    }

    var
        NameErr: Label 'Company Name should not be modified';

    trigger OnInsert()
    begin
        if IsNullGuid(Id) then
            Id := CreateGuid();
    end;
}
