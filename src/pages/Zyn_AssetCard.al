page 50202 Zyn_AssetCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Zyn_Assets;

    layout
    {
        area(Content)
        {
            group(AssetCard)
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
    trigger OnAfterGetRecord()
    begin
        Rec.UpdateAvailability();
    end;
}
