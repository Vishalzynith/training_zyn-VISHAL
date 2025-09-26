page 50216 Zyn_ExpenseClaimCategory
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = Zyn_ExpenseCategory;
    UsageCategory = Lists;
    Caption = 'Expense Categories';
    layout
    {
        area(Content)
        {
            repeater(ExpenseClaimCatList)
            {
                field(Code; Rec.Code)
                {
                    Caption = 'Category Code';
                }
                field(EmpID; Rec.EmpID)
                {
                    Caption = 'Employee ID';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Category Name';
                }
                field(SubType; Rec.SubType)
                {
                    Caption = 'Sub Type';
                }
                field(Limit; Rec.Limit)
                {
                    Caption = 'Limit Amount';
                }
                field(ClaimedAmount; Rec.ClaimedAmount)
                {
                    Caption = 'Claimed Amount';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(NewCategory)
            {
                Caption = 'New';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = New;
                Image = New;
                RunObject = page Zyn_ExpenseClaimCategory;
            }
        }
    }
}
