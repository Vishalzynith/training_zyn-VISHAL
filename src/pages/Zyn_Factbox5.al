page 50205 "Zyn_AssetStatsFactbox"
{
    PageType = CardPart;
    ApplicationArea = All;
    SourceTable = EmpAssets;
    Caption = 'Asset History';

    layout
    {
        area(Content)
        {
            cuegroup(TotalGroup)
            {
                Caption = 'Assets';

                field(TotalAssets; TotalAssets)
                {
                    ApplicationArea = All;
                    Caption = 'Total Assets';

                    trigger OnDrillDown()
                    var
                        TmpRec: Record EmpAssets;
                    begin
                        TmpRec.Reset();
                        PAGE.Run(PAGE::"Zyn_EmpAssetList", TmpRec);
                    end;
                }
            }
        }
    }

    var
        TotalAssets: Integer;

    trigger OnAfterGetRecord()
    var
        TmpRec: Record EmpAssets;
    begin
        TmpRec.Reset();
        TotalAssets := TmpRec.Count(); 
    end;
}
