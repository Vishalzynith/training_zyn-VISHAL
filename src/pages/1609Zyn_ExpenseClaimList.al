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
                    Caption='Claim ID';
                }
                field(EmpID;Rec.EmpID)
                {
                    Caption='Employee ID';
                }
                field(CategoryID; Rec.CategoryID)
                {
                    Caption='Category ID';
                }
                field(SubType; Rec.SubType)
                {
                    Caption='Sub Type';
                }
                field(ClaimDate; Rec.ClaimDate)
                {
                    Caption='Claim Date';
                }
                field(BillDate; Rec.BillDate)
                {
                    Caption='Bill Date';
                }
                field(Amount; Rec.Amount)
                {
                    Caption='Amount';
                }
                field(Status; Rec.Status)
                {
                    Caption='Status';
                }
                field(Remarks; Rec.Remarks)
                {
                    Caption='Remarks';
                }
            }
        }
    }
}
