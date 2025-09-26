page 50168 Zyn_ExpenseCategory
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = Zyn_Expense_Category;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    CardPageId = 50169;
    layout
    {
        area(Content)
        {
            repeater(ExpenseList)
            {
                field(CategoryNo; Rec.CategoryNo)
                {
                    Caption = 'Category No.';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Category Name';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
            }
        }
        area(FactBoxes)
        {
            part(ExpenseCatStatsFactbox; Zyn_ExpenseCategoryFactbox)
            {
                ApplicationArea = All;
                SubPageLink = Name = field(Name);
            }
            part(BudgetCatStatsFactbox; Zyn_BudgetCategoryFactbox)
            {
                ApplicationArea = All;
                SubPageLink = Name = field(Name);
            }
        }
    }
}