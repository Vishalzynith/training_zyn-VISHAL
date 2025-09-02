page 50183 BudgetCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Budget;

    layout
    {
        area(Content)
        {
            group(BudgetCard)
            {
                field(BudgetID; Rec.BudgetID) { ApplicationArea = All; }
                field("Category"; Rec.Category)
                {
                    ApplicationArea = All;
                    Caption = 'Category';
                }
                field(Amount; Rec.Amount) { ApplicationArea = All; }
                field(FromDate; Rec.FromDate) { ApplicationArea = All; }
                field(ToDate; Rec.ToDate) { ApplicationArea = All; }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        CurrYear: Integer;
        CurrMonth: Integer;
        StartDate: Date;
        EndDate: Date;
        WorkDt: Date;
    begin
        WorkDt := WorkDate();
        CurrYear := Date2DMY(WorkDt, 3);
        CurrMonth := Date2DMY(WorkDt, 2);
        StartDate := DMY2Date(1, CurrMonth, CurrYear);
        EndDate := CalcDate('<CM>', StartDate);
        Rec.FromDate := StartDate;
        Rec.ToDate := EndDate;
    end;

}
