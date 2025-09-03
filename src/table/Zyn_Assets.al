table 50170 Assets
{
    DataClassification = ToBeClassified;

    fields
    {
        field(6; AssetNo; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(1; AssetType; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = AssetType.Name;
        }
        field(2; SerialNo; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; ProcurredDate; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                UpdateAvailability();
            end;
        }
        field(4; Vendor; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Available; Boolean)
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; AssetNo, AssetType, SerialNo)
        {
            Clustered = true;
        }
    }

    procedure UpdateAvailability()
    var
        ExpiryDate: Date;
        WorkDate: Date;
        EmpAssetRec: Record EmpAssets;
    begin
        WorkDate := System.WorkDate();

        // Check 5 years expiry
        if Rec.ProcurredDate = 0D then begin
            Rec.Available := false;
            exit;
        end;
        ExpiryDate := System.CalcDate('<+5Y>', Rec.ProcurredDate);
        if WorkDate > ExpiryDate then begin
            Rec.Available := false;
            exit;
        end;

        // Check assignment status
        EmpAssetRec.Reset();
        EmpAssetRec.SetRange(SerialNo, Rec.SerialNo);

        if EmpAssetRec.FindLast() then begin
            case EmpAssetRec.Status of
                EmpAssetRec.Status::Assigned:
                    Rec.Available := false;
                EmpAssetRec.Status::Returned:
                    Rec.Available := true;
                EmpAssetRec.Status::Lost:
                    Rec.Available := false;
                else
                    Rec.Available := true;
            end;
        end else
            Rec.Available := true; 
    end;

    trigger OnInsert()
    begin
        UpdateAvailability();
    end;

    trigger OnModify()
    begin
        UpdateAvailability();
    end;

    trigger OnDelete()
    var
        EmpAssetRec: Record EmpAssets;
    begin
        
        EmpAssetRec.Reset();
        EmpAssetRec.SetRange(SerialNo, Rec.SerialNo);
        EmpAssetRec.SetRange(Status, EmpAssetRec.Status::Assigned);
        if EmpAssetRec.FindFirst() then
            Error('Cannot delete Asset %1 because it is currently assigned.', Rec.SerialNo);

        
        EmpAssetRec.Reset();
        EmpAssetRec.SetRange(SerialNo, Rec.SerialNo);
        if EmpAssetRec.FindSet() then
            repeat
                EmpAssetRec.Delete();
            until EmpAssetRec.Next() = 0;
    end;

}
