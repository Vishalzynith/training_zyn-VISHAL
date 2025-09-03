table 50169 AssetType
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; TypeNo; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; Category; Enum AssetCategory)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; TypeNo, Name)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        AssetRec: Record Assets;
        EmpAssetRec: Record EmpAssets;
    begin
        // Delete all related Assets
        AssetRec.Reset();
        AssetRec.SetRange(AssetType, Rec.Name);
        if AssetRec.FindSet() then
            repeat
                AssetRec.Delete(true); // this will cascade into EmpAssets delete via Assets.OnDelete
            until AssetRec.Next() = 0;

        // Extra safeguard: delete orphan EmpAssets (if any)
        EmpAssetRec.Reset();
        EmpAssetRec.SetRange(AssetType, Rec.Name);
        if EmpAssetRec.FindSet() then
            repeat
                EmpAssetRec.Delete();
            until EmpAssetRec.Next() = 0;
    end;


    trigger OnRename()
    begin

    end;

}