codeunit 50134 "Zyn_creditmemoTextHandler"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesCrMemoHeaderInsert', '', false, false)]
    local procedure OnAfterSalesCrMemoHeaderInsert(
        var SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesHeader: Record "Sales Header";
        CommitIsSuppressed: Boolean;
        WhseShip: Boolean;
        WhseReceive: Boolean;
        var TempWhseShptHeader: Record "Warehouse Shipment Header";
        var TempWhseRcptHeader: Record "Warehouse Receipt Header")
    begin
        CopyText(SalesHeader, SalesCrMemoHeader);
        ClearText(SalesHeader);
    end;

    local procedure CopyText(
        SalesHeader: Record "Sales Header";
        PostedCreditMemo: Record "Sales Cr.Memo Header")
    var
        SourceBuffer: Record Subpageext;
        TargetBuffer: Record Subpageext;
        NewLineNo: Integer;
        SelectionType: Enum BeginEndEnum;
    begin
        SelectionType := SelectionType::"Begin";
        repeat
            SourceBuffer.Reset();
            SourceBuffer.SetRange("No.", SalesHeader."No.");
            SourceBuffer.SetRange("customer no", SalesHeader."Sell-to Customer No.");
            SourceBuffer.SetRange(selection, SelectionType);

            if SourceBuffer.FindSet() then begin
                repeat
                    NewLineNo := GetNextLineNo(TargetBuffer, PostedCreditMemo."No.", PostedCreditMemo."Sell-to Customer No.", SelectionType);
                    TargetBuffer.Init();
                    TargetBuffer."No." := PostedCreditMemo."No.";
                    TargetBuffer."Line No." := NewLineNo;
                    TargetBuffer."Language code" := SourceBuffer."Language code";
                    TargetBuffer.Selection := SourceBuffer.Selection;
                    TargetBuffer."customer no" := PostedCreditMemo."Sell-to Customer No.";
                    TargetBuffer.Description := SourceBuffer.Description;
                    TargetBuffer.Text := SourceBuffer.Text;
                    TargetBuffer.Insert(true);
                until SourceBuffer.Next() = 0;
            end;

            //next enum value
            if SelectionType = SelectionType::"Begin" then
                SelectionType := SelectionType::"End"
            else
                exit;

        until false;
    end;

    local procedure ClearText(SalesHeader: Record "Sales Header")
    var
        SourceBuffer: Record Subpageext;
    begin
        SourceBuffer.SetRange("No.", SalesHeader."No.");
        SourceBuffer.SetRange("customer no", SalesHeader."Sell-to Customer No.");
        SourceBuffer.DeleteAll();
    end;

    local procedure GetNextLineNo(Buffer: Record Subpageext; DocNo: Code[20]; CustNo: Code[20]; Sel: Enum BeginEndEnum): Integer
    var
        MaxLineNo: Integer;
    begin
        Buffer.Reset();
        Buffer.SetRange("No.", DocNo);
        Buffer.SetRange("customer no", CustNo);
        Buffer.SetRange(Selection, Sel);
        if Buffer.FindLast() then
            MaxLineNo := Buffer."Line No.";
        exit(MaxLineNo + 10000);
    end;
}
