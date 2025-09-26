page 50204 Zyn_EmpAssetCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Zyn_EmpAssets;
    layout
    {
        area(Content)
        {
            group(BudgetCard)
            {
                field(EmpID; Rec.EmpID)
                {
                    Caption = 'Employee ID';
                }
                field(AssetType; Rec.AssetType)
                {
                    Caption = 'Asset Type';
                }
                field(SerialNo; Rec.SerialNo)
                {
                    Caption = 'Serial No';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                field(AssignedDate; Rec.AssignedDate)
                {
                    Caption = 'Assigned Date';
                    Editable = EditAssign;
                }
                field(ReturnedDate; Rec.ReturnedDate)
                {
                    Caption = 'Returned Date';
                    Editable = EditReturn;
                }
                field(LostDate; Rec.LostDate)
                {
                    Caption = 'Lost Date';
                    Editable = EditLost;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        AssetsRecord: Record Zyn_Assets;
        ExpiryDate: Date;
        AssetStatus: Enum Zyn_AssetStatus;
    begin
        EditAssign := false;
        EditReturn := false;
        EditLost := false;

        if Rec.SerialNo <> '' then begin
            AssetsRecord.Reset();
            AssetsRecord.SetRange(SerialNo, Rec.SerialNo);
            if AssetsRecord.FindFirst() then begin
                AssetsRecord.UpdateAvailability();

                case Rec.Status of
                    AssetStatus::Assigned:
                        begin
                            EditAssign := true;
                            EditReturn := false;
                            EditLost := false;
                        end;
                    AssetStatus::Returned:
                        begin
                            EditAssign := true;
                            EditReturn := true;
                            EditLost := false;
                        end;
                    AssetStatus::Lost:
                        begin
                            EditAssign := true;
                            EditReturn := false;
                            EditLost := true;
                        end;
                end;
            end;
        end;
    end;
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        case Rec.Status of
            Rec.Status::Assigned:
                if Rec.AssignedDate = 0D then
                    Error(AssignErr);
            Rec.Status::Returned:
                if (Rec.AssignedDate = 0D) or (Rec.ReturnedDate = 0D) then
                    Error(ReturnErr);
            Rec.Status::Lost:
                if (Rec.AssignedDate = 0D) or (Rec.LostDate = 0D) then
                    Error(LostErr);
        end;
        exit(true);
    end;
    var
        AssignErr: Label 'Assigned Date must be filled when status is Assigned.';
        ReturnErr: Label 'Both Assigned Date and Returned Date must be filled when status is Returned.';
        LostErr: Label 'Both Assigned Date and Lost Date must be filled when status is Lost.';
        EditAssign: Boolean;
        EditReturn: Boolean;
        EditLost: Boolean;
}

