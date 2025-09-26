page 50129 Zyn_CompanyList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Zyn_Company;

    layout
    {
        area(Content)
        {
            repeater(CompanyList)
            {
                field("Business Profile Id"; Rec."Business Profile Id") { }
                field(Name; Rec.Name) { }
                field(Id; Rec.Id) { }
                field("Evaluation Company"; Rec."Evaluation Company") { }
                field("Display Name"; Rec."Display Name") { }
                field(IsMaster; Rec.IsMaster) { }
                field(MasterCompanyName; Rec.MasterCompanyName) { }
                field(MasterCompanyId; Rec.MasterCompanyId) { }
                // Removed IsStandalone (implicit now)
            }
        }
    }

    trigger OnOpenPage()
    var
        SystemCompany: Record Company;
        MyCompany: Record Zyn_Company;
    begin
        if MyCompany.IsEmpty() then begin
            if SystemCompany.FindSet() then
                repeat
                    if not MyCompany.Get(SystemCompany.Name) then begin
                        MyCompany.Init();
                        MyCompany.Name := SystemCompany.Name;
                        MyCompany."Evaluation Company" := SystemCompany."Evaluation Company";
                        MyCompany."Display Name" := SystemCompany."Display Name";
                        MyCompany.Id := SystemCompany.Id;
                        MyCompany."Business Profile Id" := SystemCompany."Business Profile Id";
                        MyCompany.Insert();
                    end;
                until SystemCompany.Next() = 0;
        end;
    end;
}
