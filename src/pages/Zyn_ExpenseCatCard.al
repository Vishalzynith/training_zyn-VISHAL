page 50169 Zyn_ExpenseCategoryCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Zyn_Expense_Category;

    layout
    {
        area(Content)
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
        area(Factboxes)
        {

        }
    }
}