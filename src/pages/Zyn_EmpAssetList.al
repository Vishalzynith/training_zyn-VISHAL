page 50203 "Zyn_EmpAssetList"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = EmpAssets;
    CardPageId = 50204;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(EmpAssetList)
            {
                field(EmpID; Rec.EmpID) { ApplicationArea = All; }
                field(SerialNo; Rec.SerialNo) { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; }
                field(AssignedDate; Rec.AssignedDate) { ApplicationArea = All; }
                field(ReturnedDate; Rec.ReturnedDate) { ApplicationArea = All; }
                field(LostDate; Rec.LostDate) { ApplicationArea = All; }
            }
        }

        area(FactBoxes)
        {
            part(AssetStats; "Zyn_AssetStatsFactbox")
            {
                ApplicationArea = All;
                SubPageLink = EmpID = field(EmpID); 
            }
        }
    }

}
