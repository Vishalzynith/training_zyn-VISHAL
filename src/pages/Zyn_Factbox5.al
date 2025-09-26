page 50205 "Zyn_AssetStatsFactbox"
{
    PageType = CardPart;
    ApplicationArea = All;
    SourceTable = Zyn_EmpAssets;
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
                    Caption = 'Total Assets';
                    trigger OnDrillDown()
                    var
                        EmployeeAssetsRecord: Record Zyn_EmpAssets;
                    begin
                        EmployeeAssetsRecord.Reset();
                        PAGE.Run(PAGE::"Zyn_EmpAssetList", EmployeeAssetsRecord);
                    end;
                }
            }
        }
    }
    var
        TotalAssets: Integer;

    trigger OnAfterGetRecord()
    var
        EmployeeAssetsRecord: Record Zyn_EmpAssets;
    begin
        EmployeeAssetsRecord.Reset();
        TotalAssets := EmployeeAssetsRecord.Count();
    end;
}
