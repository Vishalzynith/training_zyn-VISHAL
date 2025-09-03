page 50375 "Assigned Assets Factbox"
{
    Caption = 'Assigned Assets';
    PageType = CardPart;
    SourceTable = "Employ Table"; // Employee table
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup("Assets Summary")
            {
                field("Assigned Asset Count"; Rec."Assigned Asset Count")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        EmpAssetRec: Record EmpAssets;
                        EmpAssetList: Page "Zyn_EmpAssetList";
                    begin
                        EmpAssetRec.Reset();
                        EmpAssetRec.SetRange(EmpID, Rec."Emp Id.");
                        EmpAssetRec.SetRange(Status, EmpAssetRec.Status::Assigned);

                        if EmpAssetRec.FindSet() then begin
                            EmpAssetList.SetTableView(EmpAssetRec);
                            EmpAssetList.Run();
                        end else
                            Message('No assigned assets for employee %1.', Rec."Emp Id.");
                    end;
                }
            }
        }
    }
}
