page 50203 "Zyn_EmpAssetList"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Zyn_EmpAssets;
    CardPageId = 50204;
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(EmpAssetList)
            {
                field(EmpID; Rec.EmpID)
                {
                    Caption = 'Employee ID';
                }
                field(SerialNo; Rec.SerialNo)
                {
                    Caption = 'Serial No';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(AssignedDate; Rec.AssignedDate)
                {
                    Caption = 'Assigned Date';
                }
                field(ReturnedDate; Rec.ReturnedDate)
                {
                    Caption = 'Returned Date';
                }
                field(LostDate; Rec.LostDate)
                {
                    Caption = 'Lost Date';
                }
            }
        }
        area(FactBoxes)
        {
            part(AssetStats; "Zyn_AssetStatsFactbox")
            {
                SubPageLink = EmpID = field(EmpID);
            }
        }
    }
}
