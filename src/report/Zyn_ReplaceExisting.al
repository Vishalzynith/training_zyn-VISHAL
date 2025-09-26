report 50143 Zyn_ReplaceExisting
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            trigger OnPreDataItem();
            begin
                clear(Counts);
            end;

            trigger OnAfterGetRecord();
            begin
                if Customer.get(Customer."No.") then begin
                    Customer."Name" := Replacename;
                    Customer.Modify;
                    Counts += 1;
                end;
            end;

            trigger OnPostDataItem();
            begin
                Message(' %1 Customers were updated.', Counts);
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Replacename; Replacename)
                    {
                        ApplicationArea = All;
                        Caption = 'Name to be replaced';
                    }
                }
            }
        }
    }
    var
        Replacename: Text[50];
        Counts: Integer;

    //Customer variable is aldready defined in the package. So it is not needed to define again as it shows error that it is aldready defined.
}