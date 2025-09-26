page 50219 Zyn_PendingExpenseClaims
{
    PageType = List;
    SourceTable = Zyn_ExpenseClaim;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Pending Expense Claims';
    SourceTableView = WHERE(Status = CONST(Pending));
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID; Rec.ID)
                {
                    Caption='Claim ID';
                }
                field(Category; Rec.Category)
                {
                    Caption='Category';
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
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Approve)
            {
                Caption = 'Approve';
                Image = Approve;
                ApplicationArea = All;
                Promoted = true;
                trigger OnAction()
                var
                    EmpenseClaimManagement: Codeunit Zyn_ExpenseClaimManagement;
                    Claim: Record Zyn_ExpenseClaim;
                begin
                    CurrPage.Update(false);
                    Claim := Rec;
                    EmpenseClaimManagement.ApproveClaim(Claim);
                    Claim.Modify();
                    Message('Claim %1 approved.', Claim.ID);
                    CurrPage.Update();
                end;
            }
            action(Reject)
            {
                Caption = 'Reject';
                ApplicationArea = All;
                Promoted = true;
                trigger OnAction()
                var
                    EmpenseClaimManagement: Codeunit Zyn_ExpenseClaimManagement;
                    Claim: Record Zyn_ExpenseClaim;
                begin
                    CurrPage.Update(false);
                    Claim := Rec;
                    EmpenseClaimManagement.RejectClaim(Claim);
                    Claim.Modify();
                    Message('Claim %1 rejected.', Claim.ID);
                    CurrPage.Update();
                end;
            }
        }
    }
}
