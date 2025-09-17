page 50216 Zyn_ExpenseClaimCat
{
    PageType = List;
    SourceTable = Zyn_ExpenseCategory;
    ApplicationArea = All;
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
                    ApplicationArea = All;
                }
                field(EmpID;Rec.EmpID)
                {
                    ApplicationArea=All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(SubType; Rec.SubType)
                {
                    ApplicationArea = All;
                }
                field(Limit; Rec.Limit)
                {
                    ApplicationArea = All;
                }
                field(ClaimedAmount; Rec.ClaimedAmount)
                {
                    ApplicationArea = All;
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
                RunObject = page Zyn_ExpenseClaimCat;
            }
        }
    }
}
