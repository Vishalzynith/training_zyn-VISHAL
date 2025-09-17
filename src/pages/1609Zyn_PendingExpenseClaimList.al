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
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
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
                    ApproveRef: Codeunit Zyn_ExpenseClaimManagement;
                    Claim: Record Zyn_ExpenseClaim;
                begin
                    CurrPage.Update(false);
                    Claim := Rec;
                    ApproveRef.ApproveClaim(Claim);
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
                    ApproveRef: Codeunit Zyn_ExpenseClaimManagement;
                    Claim: Record Zyn_ExpenseClaim;
                begin
                    CurrPage.Update(false);
                    Claim := Rec;
                    ApproveRef.RejectClaim(Claim);
                    Claim.Modify();
                    Message('Claim %1 rejected.', Claim.ID);
                    CurrPage.Update();
                end;
            }
        }
    }
}
