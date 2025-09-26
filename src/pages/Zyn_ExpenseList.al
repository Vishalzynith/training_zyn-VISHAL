page 50166 Zyn_ExpenseList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Zyn_Expense;
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
                field(ExpenseID; Rec.ExpenseID)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Category; Rec.Category)
                {
                }
                field(Date; Rec.Date)
                {
                }
            }
        }
        area(FactBoxes)
        {
            part(BudgetListFactbox; Zyn_BudgetListPart)
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
                RunObject = page Zyn_ExpenseCategory;
            }
            action(ExpenseExportFilter)
            {
                ApplicationArea = All;
                Caption = 'Export Filtered Expenses';
                RunObject = report Zyn_ExpenseFilterPage;
            }
            action(ExpensevsBudget)
            {
                ApplicationArea = All;
                Caption = 'Expense versus Budget';
                RunObject = report Zyn_BudgetvsExpense;
            }
        }
    }
}