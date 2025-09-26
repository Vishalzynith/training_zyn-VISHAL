page 50190 Zyn_BudgetListPart
{
    PageType = Listpart;
    ApplicationArea = All;
    SourceTable = Zyn_Budget;
    Editable = false;
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

}