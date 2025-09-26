page 50183 Zyn_BudgetCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Zyn_Budget;

    layout
    {
        area(Content)
        {
            group(BudgetCard)
            {
                field(BudgetID; Rec.BudgetID)
                {
                    Caption = 'Budget ID';
                }
                field("Category"; Rec.Category)
                {
                    Caption = 'Category';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(FromDate; Rec.FromDate)
                {
                    Caption = 'From Date';
                }
                field(ToDate; Rec.ToDate)
                {
                    Caption = 'To Date';
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        CurrentYear: Integer;
        CurrentMonth: Integer;
        StartDate: Date;
        EndDate: Date;
        WorkDate: Date;
    begin
        WorkDate := WorkDate();
        CurrentYear := Date2DMY(WorkDate, 3);
        CurrentMonth := Date2DMY(WorkDate, 2);
        StartDate := DMY2Date(1, CurrentMonth, CurrentYear);
        EndDate := CalcDate('<CM>', StartDate);
        Rec.FromDate := StartDate;
        Rec.ToDate := EndDate;
    end;

}
