table 50169 Zyn_AssetType
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; TypeNo; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; Category; Enum Zyn_AssetCategory)
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
        AssetRec: Record Zyn_Assets;
        EmpAssetRec: Record Zyn_EmpAssets;
    begin

        AssetRec.Reset();
        AssetRec.SetRange(AssetType, Rec.Name);
        if AssetRec.FindSet() then
            repeat
                AssetRec.Delete(true);
            until AssetRec.Next() = 0;


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