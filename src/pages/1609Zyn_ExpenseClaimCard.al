page 50218 Zyn_ExpenseClaimCard
{
    PageType = Card;
    SourceTable = Zyn_ExpenseClaim;
    ApplicationArea = All;
    Caption = 'Expense Claim';
    layout
    {
        area(content)
        {
            group(General)
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
                    trigger OnValidate()
                    var
                        ExpCat: Record Zyn_ExpenseCategory;
                    begin
                        if (Rec.CategoryID <> 0) and ExpCat.Get(Rec.CategoryID) then begin
                            if Rec.Amount > ExpCat.Limit then
                                Error('Amount %1 exceeds the limit %2 for this category.', Rec.Amount, ExpCat.Limit);
                        end;
                    end;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Bill; Rec.Bill)
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
            action(CancelClaim)
            {
                Caption = 'Cancel Claim';
                ApplicationArea = All;
                trigger OnAction()
                var
                    ClaimMgt: Codeunit Zyn_ExpenseClaimManagement;
                    Claim: Record Zyn_ExpenseClaim;
                begin
                    Claim := Rec;
                    ClaimMgt.CancelClaim(Claim);
                    Claim.Modify();
                    Message('Claim %1 cancelled.', Claim.ID);
                    CurrPage.Update();
                end;
            }
            action(UploadBill)
            {
                Caption = 'Upload Bill';
                Image = Import;
                ApplicationArea = All;
                trigger OnAction()
                var
                    FileName: Text;
                    InS: InStream;
                    OutS: OutStream;
                begin
                    if UploadIntoStream('Select file', '', '', FileName, InS) then begin
                        Clear(Rec.Bill);
                        Rec.Bill.CreateOutStream(OutS);
                        CopyStream(OutS, InS);
                        Rec.Modify();
                        Message('File %1 uploaded successfully!', FileName);
                    end;
                end;
            }
            action(DownloadBill)
            {
                Caption = 'Download Bill';
                Image = Export;
                ApplicationArea = All;
                trigger OnAction()
                var
                    OutS: OutStream;
                    InS: InStream;
                    TempFile: Text;
                begin
                    if not Rec.Bill.HasValue then
                        Error('No file available.');
                    TempFile := 'ClaimBill_' + Format(Rec.ID) + '.pdf';
                    Rec.Bill.CreateInStream(InS);
                    DownloadFromStream(InS, '', '', '', TempFile);
                end;

            }
        }
    }
}
