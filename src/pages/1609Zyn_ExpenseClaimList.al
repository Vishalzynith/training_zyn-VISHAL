page 50217 Zyn_ExpenseClaimList
{
    PageType = List;
    SourceTable = Zyn_ExpenseClaim;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Expense Claims';
    Editable = false;
    CardPageID = Zyn_ExpenseClaimCard;
    layout
    {
        area(content)
        {
            repeater(ExpenseClaimList)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                }
                field(EmpID;Rec.EmpID)
                {
                    ApplicationArea=All;
                }
                field(CategoryID; Rec.CategoryID)
                {
                    ApplicationArea = All;
                }
                field(SubType; Rec.SubType)
                {
                    ApplicationArea = All;
                }
                field(ClaimDate; Rec.ClaimDate)
                {
                    ApplicationArea = All;
                }
                field(BillDate; Rec.BillDate)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
