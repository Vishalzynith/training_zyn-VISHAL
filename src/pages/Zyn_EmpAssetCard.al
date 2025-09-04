page 50204 EmpAssetCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = EmpAssets;

    layout
    {
        area(Content)
        {
            group(BudgetCard)
            {
                field(EmpID; Rec.EmpID) { ApplicationArea = All; }
                field(AssetType;Rec.AssetType){ApplicationArea=All;}
                field(SerialNo; Rec.SerialNo) { ApplicationArea = All; }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                field(AssignedDate; Rec.AssignedDate)
                 {
                     ApplicationArea = All;
                      Editable = EditAssgn; 
                    }
                field(ReturnedDate; Rec.ReturnedDate) 
                {
                     ApplicationArea = All; 
                     Editable = EditReturn;
                      }
                field(LostDate; Rec.LostDate)
                 {
                     ApplicationArea = All;
                      Editable = EditLost;
                       }
            }
        }
    }

    var
        EditAssgn: Boolean;
        EditReturn: Boolean;
        EditLost: Boolean;
trigger OnAfterGetRecord()
var
    AssetsRec: Record Assets;
    ExpiryDate: Date;
    AssetStatus:Enum AssetStatus;
begin
    EditAssgn := false;
    EditReturn := false;
    EditLost := false;

    if Rec.SerialNo <> '' then begin
        AssetsRec.Reset();
        AssetsRec.SetRange(SerialNo, Rec.SerialNo);
        if AssetsRec.FindFirst() then begin
            AssetsRec.UpdateAvailability();

            case Rec.Status of
                AssetStatus::Assigned:
                    begin
                        EditAssgn := true;
                        EditReturn := false;
                        EditLost := false;
                    end;
                AssetStatus::Returned:
                    begin
                        EditAssgn := true;
                        EditReturn := true;   
                        EditLost := false;
                    end;
                AssetStatus::Lost:
                    begin
                        EditAssgn := true;
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
                Error('Assigned Date must be filled when status is Assigned.');
        Rec.Status::Returned:
            if (Rec.AssignedDate = 0D) or (Rec.ReturnedDate = 0D) then
                Error('Both Assigned Date and Returned Date must be filled when status is Returned.');
        Rec.Status::Lost:
            if (Rec.AssignedDate = 0D) or (Rec.LostDate = 0D) then
                Error('Both Assigned Date and Lost Date must be filled when status is Lost.');
    end;
    exit(true);
end;
}

