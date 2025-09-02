page 50166 ExpenseList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Expense;
    CardPageId = 50167;
    //Editable=false;
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(ExpenseList)
            {
                field(ExpenseID; Rec.ExpenseID) { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field(Amount; Rec.Amount) { ApplicationArea = All; }
                field(Category; Rec.Category) { ApplicationArea = All; }
                field(Date; Rec.Date) { ApplicationArea = All; }
            }
        }
        area(FactBoxes)
        {
            part(BudgetListFactbox; BudgetListPart)
            {
                ApplicationArea = All;
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
            action(ExpensevsBudget)
            {
                ApplicationArea=All;
                Caption='Expense versus Budget';
                RunObject=report "Budget vs Expense Report";
            }
        }
    }
}