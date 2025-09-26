page 50182 Zyn_BudgetList
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = Zyn_Budget;
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
                field(BudgetID; Rec.BudgetID)
                {
                    Caption = 'Budget ID';
                }
                field(Category; Rec.Category)
                {
                    Caption = 'Category';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Budget Amount';
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
    actions
    {
        area(processing)
        {
            action(SelectCategory)
            {
                ApplicationArea = All;
                Caption = 'Select Category';
                RunObject = page Zyn_ExpenseCategory;
            }
            action(ExpenseExportFilter)
            {
                ApplicationArea = All;
                Caption = 'Export Filtered Expenses';
                RunObject = report Zyn_ExpenseFilterPage;
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