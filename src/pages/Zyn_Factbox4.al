page 50375 Zyn_AssignedAssetsFactbox
{
    Caption = 'Assigned Assets';
    PageType = CardPart;
    SourceTable = Zyn_Employee; // Employee table
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            cuegroup("Assets Summary")
            {
                field("Assigned Asset Count"; Rec."Assigned Asset Count")
                {
                    Caption = 'Assigned Asset Count';
                    trigger OnDrillDown()
                    var
                        EmpAssetRec: Record Zyn_EmpAssets;
                        EmpAssetList: Page "Zyn_EmpAssetList";
                    begin
                        EmpAssetRec.Reset();
                        EmpAssetRec.SetRange(EmpID, Rec."Emp Id.");
                        EmpAssetRec.SetRange(Status, EmpAssetRec.Status::Assigned);

                        if EmpAssetRec.FindSet() then begin
                            EmpAssetList.SetTableView(EmpAssetRec);
                            EmpAssetList.Run();
                        end else
                            Message(AssignedCountMsg,Rec."Emp Id.");
                    end;
                }
            }
        }
    }
    var AssignedCountMsg: Label 'No assigned assets for employee %1.';
}
