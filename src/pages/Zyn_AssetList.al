page 50201 Zyn_AssetList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Zyn_Assets;
    CardPageId = 50202;
    //Editable=false;
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(AssetsList)
            {
               field(AssetType; Rec.AssetType)
                {
                    Caption='Asset Type';
                }
                field(SerialNo; Rec.SerialNo)
                {
                    Caption='Serial No.';
                }
                field(ProcurredDate; Rec.ProcurredDate)
                {
                    Caption='Procurred Date';
                }
                field(Vendor; Rec.Vendor)
                {
                    Caption='Vendor';
                }
                field(Available; Rec.Available)
                {
                    Caption='Avaialable';
                }
            }
        }
    }
}