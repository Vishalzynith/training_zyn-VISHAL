table 50171 Zyn_EmpAssets
{
    DataClassification = ToBeClassified;

    fields
    {
        field(2; EmpID; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Zyn_Employee."Emp Id.";
        }
        field(8; AssetType; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Zyn_AssetType.Name;
        }
        field(3; SerialNo; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Zyn_Assets.SerialNo;
        }
        field(4; Status; Enum Zyn_AssetStatus)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                AssetsRec: Record Zyn_Assets;
                PrevEmpAsset: Record Zyn_EmpAssets;
                ExpiryDate: Date;
            begin

                AssetsRec.Reset();
                AssetsRec.SetRange(SerialNo, Rec.SerialNo);
                if not AssetsRec.FindFirst() then
                    Error('Asset with SerialNo %1 does not exist in Assets table.', Rec.SerialNo);


                if Rec.Status = Status::Assigned then begin

                    AssetsRec.UpdateAvailability();
                    if not AssetsRec.Available then
                        Error('Asset %1 is not available for assignment (procured %2).', Rec.SerialNo, AssetsRec.ProcurredDate);

                end else if Rec.Status = Status::Returned then begin

                    PrevEmpAsset.Reset();
                    PrevEmpAsset.SetRange(SerialNo, Rec.SerialNo);
                    PrevEmpAsset.SetRange(EmpID, Rec.EmpID);
                    PrevEmpAsset.SetRange(Status, Status::Assigned);
                    if PrevEmpAsset.FindLast() then
                        Rec.AssignedDate := PrevEmpAsset.AssignedDate
                    else begin

                        PrevEmpAsset.Reset();
                        PrevEmpAsset.SetRange(SerialNo, Rec.SerialNo);
                        PrevEmpAsset.SetRange(Status, Status::Assigned);
                        if PrevEmpAsset.FindLast() then
                            Rec.AssignedDate := PrevEmpAsset.AssignedDate;
                    end;


                    ExpiryDate := System.CalcDate('<+5Y>', AssetsRec.ProcurredDate);
                    if Rec.ReturnedDate <> 0D then
                        if Rec.ReturnedDate > ExpiryDate then
                            Error('ReturnedDate %1 exceeds 5-year window (procured %2).', Rec.ReturnedDate, AssetsRec.ProcurredDate);


                    if System.WorkDate() <= ExpiryDate then
                        AssetsRec.Available := true
                    else
                        AssetsRec.Available := false;
                    AssetsRec.Modify();
                end else if Rec.Status = Status::Lost then begin

                    PrevEmpAsset.Reset();
                    PrevEmpAsset.SetRange(SerialNo, Rec.SerialNo);
                    PrevEmpAsset.SetRange(EmpID, Rec.EmpID);
                    PrevEmpAsset.SetRange(Status, Status::Assigned);
                    if PrevEmpAsset.FindLast() then
                        Rec.AssignedDate := PrevEmpAsset.AssignedDate
                    else begin
                        PrevEmpAsset.Reset();
                        PrevEmpAsset.SetRange(SerialNo, Rec.SerialNo);
                        PrevEmpAsset.SetRange(Status, Status::Assigned);
                        if PrevEmpAsset.FindLast() then
                            Rec.AssignedDate := PrevEmpAsset.AssignedDate;
                    end;


                    AssetsRec.Available := false;
                    AssetsRec.Modify();
                end;
            end;
        }
        field(5; AssignedDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; ReturnedDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; LostDate; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; EmpID, SerialNo)
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
    begin
    end;

    trigger OnRename()
    begin
    end;
}
