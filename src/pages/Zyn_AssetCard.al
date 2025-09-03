page 50202 AssetCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Assets;

    layout
    {
        area(Content)
        {
            group(AssetCard)
            {
                field(AssetType; Rec.AssetType) 
                { 
                    ApplicationArea = All; 
                }
                field(SerialNo; Rec.SerialNo) 
                { 
                    ApplicationArea = All; 
                }
                field(ProcurredDate; Rec.ProcurredDate) 
                { 
                    ApplicationArea = All; 
                }
                field(Vendor; Rec.Vendor) 
                { 
                    ApplicationArea = All; 
                }
                field(Available; Rec.Available) 
                { 
                    ApplicationArea = All; 
                
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.UpdateAvailability();
    end;
}
