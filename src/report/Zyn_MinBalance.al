report 50102 Zyn_CustomerBalanceReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    

    dataset
    {
        dataitem(Cust; Customer)
        {
            trigger OnPreDataItem()
            begin
                SetFilter("Balance", '>=%1', MinBalance);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Balance Filter")
                {
                    field("Minimum Balance"; MinBalance)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    var
        MinBalance: Decimal;
}
