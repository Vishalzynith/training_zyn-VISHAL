table 50171 EmpAssets
{
    DataClassification = ToBeClassified;

    fields
    {
        field(2;EmpID;Code[20])
        {
            DataClassification=ToBeClassified;
            TableRelation="Employ Table"."Emp Id.";
        }
        field(8;AssetType;Text[50])
        {
            DataClassification=ToBeClassified;
            TableRelation=AssetType.Name;
        }
        field(3;SerialNo;Code[20])
        {
            DataClassification=ToBeClassified;
            TableRelation=Assets.SerialNo;
        }
        field(4;Status;Enum AssetStatus)
        {
            DataClassification=ToBeClassified;
            trigger OnValidate()
            var
                AssetsRec: Record Assets;
                PrevEmpAsset: Record EmpAssets;
                ExpiryDate: Date;
            begin
                // Make sure the asset exists
                AssetsRec.Reset();
                AssetsRec.SetRange(SerialNo, Rec.SerialNo);
                if not AssetsRec.FindFirst() then
                    Error('Asset with SerialNo %1 does not exist in Assets table.', Rec.SerialNo);

                // Branch by selected status
                if Rec.Status = Status::Assigned then begin
                    // Assignment allowed only when asset is Available
                    // Re-evaluate availability just in case
                    AssetsRec.UpdateAvailability();
                    if not AssetsRec.Available then
                        Error('Asset %1 is not available for assignment (procured %2).', Rec.SerialNo, AssetsRec.ProcurredDate);
                    // AssignedDate will be editable at page level (page controls handle that)
                end else if Rec.Status = Status::Returned then begin
                    // Populate AssignedDate from previous Assigned record for same EmpID + SerialNo
                    PrevEmpAsset.Reset();
                    PrevEmpAsset.SetRange(SerialNo, Rec.SerialNo);
                    PrevEmpAsset.SetRange(EmpID, Rec.EmpID);
                    PrevEmpAsset.SetRange(Status, Status::Assigned);
                    if PrevEmpAsset.FindLast() then
                        Rec.AssignedDate := PrevEmpAsset.AssignedDate
                    else begin
                        // fallback: get last assigned record for serial (any Emp)
                        PrevEmpAsset.Reset();
                        PrevEmpAsset.SetRange(SerialNo, Rec.SerialNo);
                        PrevEmpAsset.SetRange(Status, Status::Assigned);
                        if PrevEmpAsset.FindLast() then
                            Rec.AssignedDate := PrevEmpAsset.AssignedDate;
                    end;

                    // If ReturnedDate is already set validate it's within 5 years
                    ExpiryDate := System.CalcDate('<+5Y>', AssetsRec.ProcurredDate);
                    if Rec.ReturnedDate <> 0D then
                        if Rec.ReturnedDate > ExpiryDate then
                            Error('ReturnedDate %1 exceeds 5-year window (procured %2).', Rec.ReturnedDate, AssetsRec.ProcurredDate);

                    // Update asset availability depending on 5-year window
                    if System.WorkDate() <= ExpiryDate then
                        AssetsRec.Available := true
                    else
                        AssetsRec.Available := false;
                    AssetsRec.Modify();
                end else if Rec.Status = Status::Lost then begin
                    // Retrieve assigned date similarly
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

                    // Lost => asset no longer available
                    AssetsRec.Available := false;
                    AssetsRec.Modify();
                end;
            end;
        }
        field(5;AssignedDate;Date)
        {
            DataClassification=ToBeClassified;
        }
        field(6;ReturnedDate;Date)
        {
            DataClassification=ToBeClassified;
        }
        field(7;LostDate;Date)
        {
            DataClassification=ToBeClassified;
        }
    }

    keys
    {
        key(PK;EmpID,SerialNo)
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
