page 50182 BudgetList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Budget;
    CardPageId = 50183;
    //Editable=false;
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(BudgetList)
            {
                field(BudgetID; Rec.BudgetID) { ApplicationArea = All; }
                field(Category; Rec.Category) { ApplicationArea = All; }
                field(Amount; Rec.Amount) { ApplicationArea = All; }
                field(FromDate; Rec.FromDate) { ApplicationArea = All; }
                field(ToDate; Rec.ToDate) { ApplicationArea = All; }
            }
        }
        
    }
    actions
    {
        area(processing)
        {
            action(SelectCategory)
            {
                ApplicationArea = All;
                Caption = 'SelectCategory';
                RunObject = page "ExpenseCat";
            }
            action(ExpenseExportFilter)
            {
                ApplicationArea = All;
                Caption = 'Export Filtered Expenses';
                RunObject = report ExpenseFilterPage;
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