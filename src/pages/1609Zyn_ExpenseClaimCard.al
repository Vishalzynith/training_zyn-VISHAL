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
                    Caption = 'Claim ID';
                }
                field(EmpID; Rec.EmpID)
                {
                    Caption = 'Employee ID';
                    trigger OnValidate()
                    begin
                        CurrPage.Update(); // refreshing rem list
                    end;
                }
                field(CategoryID; Rec.CategoryID)
                {
                    Caption = 'Category ID';
                    trigger OnValidate()
                    begin
                        CurrPage.Update(); 
                    end;
                }
                field(SubType; Rec.SubType)
                {
                    Caption = 'Sub Type';
                }
                field(ClaimDate; Rec.ClaimDate)
                {
                    Caption = 'Claim Date';
                    trigger OnValidate()
                    begin
                        CurrPage.Update(); 
                    end;
                }
                field(BillDate; Rec.BillDate)
                {
                    Caption = 'Bill Date';
                }
                field(RemainingLimit; Rec.RemainingLimit)
                {
                    Caption = 'Remaining Limit';
                }
                field(Amount; Rec.Amount)
                {
                    Caption='Amount';
                    trigger OnValidate()
                    var
                        ExpCat: Record Zyn_ExpenseCategory;
                    begin
                        if (Rec.CategoryID <> 0) and ExpCat.Get(Rec.CategoryID) then begin
                            if Rec.Amount > ExpCat.Limit then
                                Error('Amount %1 exceeds the limit %2 for this category.', Rec.Amount, ExpCat.Limit);
                        end;
                        CurrPage.Update(); 
                    end;
                }
                field(Status; Rec.Status)
                {
                    Caption='Status';
                }
                field(Remarks; Rec.Remarks)
                {
                    Caption='Remarks';
                }
                field(Bill; Rec.Bill)
                {
                    Caption='Bill';
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
                trigger OnAction()
                var
                    ExpenseClaimManagement: Codeunit Zyn_ExpenseClaimManagement;
                    Claim: Record Zyn_ExpenseClaim;
                begin
                    Claim := Rec;
                    ExpenseClaimManagement.CancelClaim(Claim);
                    Claim.Modify();
                    Message('Claim %1 cancelled.', Claim.ID);
                    CurrPage.Update();
                end;
            }
            action(UploadBill)
            {
                Caption = 'Upload Bill';
                Image = Import;
                trigger OnAction()
                var
                    FileName: Text;
                    InStream: InStream;
                    OutStream: OutStream;
                begin
                    if UploadIntoStream('Select file', '', '', FileName, InStream) then begin
                        Clear(Rec.Bill);
                        Rec.Bill.CreateOutStream(OutStream);
                        CopyStream(OutStream, InStream);
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
                    InStream: InStream;
                    TempFile: Text;
                begin
                    if not Rec.Bill.HasValue then
                        Error('No file available.');
                    TempFile := 'ClaimBill_' + Format(Rec.ID) + '.pdf';
                    Rec.Bill.CreateInStream(InStream);
                    DownloadFromStream(InStream, '', '', '', TempFile);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if (Rec.EmpID <> '') and (Rec.CategoryID <> 0) and (Rec.ClaimDate <> 0D) then
            Rec.CalcRemainingLimit();
    end;
}
