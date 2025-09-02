codeunit 50131 "PostedBeginText"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDoc(
        var SalesHeader: Record "Sales Header";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        SalesShptHdrNo: Code[20];
        RetRcpHdrNo: Code[20];
        SalesInvHdrNo: Code[20];
        SalesCrMemoHdrNo: Code[20];
        CommitIsSuppressed: Boolean;
        InvtPickPutaway: Boolean;
        var CustLedgerEntry: Record "Cust. Ledger Entry";
        WhseShip: Boolean;
        WhseReceiv: Boolean;
        PreviewMode: Boolean)
    var
        PostedSalesInvoice: Record "Sales Invoice Header";
        PostedDisp: Record "Standard Text";
    begin
        if SalesInvHdrNo <> '' then begin
            if PostedSalesInvoice.Get(SalesInvHdrNo) then
                BeginToPosted(SalesHeader, PostedSalesInvoice);
            UpdateLastSoldPrices(PostedSalesInvoice);
            //InvTextToPosted(SalesHeader, PostedSalesInvoice);

            ClrUnposted(SalesHeader);
        end;
    end;

    local procedure BeginToPosted(SalesHeader: Record "Sales Header"; PostedInvoice: Record "Sales Invoice Header")
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
            SourceBuffer.SetRange(Selection, SelectionType);
            if SourceBuffer.FindSet() then begin
                repeat
                    NewLineNo := GetNextLineNo(TargetBuffer, PostedInvoice."No.", PostedInvoice."Sell-to Customer No.", SelectionType);
                    TargetBuffer.Init();
                    TargetBuffer."No." := PostedInvoice."No.";
                    TargetBuffer."Line No." := NewLineNo;
                    TargetBuffer."Language code" := SourceBuffer."Language code";
                    TargetBuffer.Selection := SourceBuffer.Selection;
                    TargetBuffer."customer no" := PostedInvoice."Sell-to Customer No.";
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
    local procedure ClrUnposted(SalesHeader: Record "Sales Header")
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

    local procedure InvTextToPosted(SalesHeader: Record "Sales Header"; PostedInvoice: Record "Sales Invoice Header")
    var
        StdText: Record "Extended Text Line";
        Buffer: Record Subpageext;
        Customer: Record Customer;
        NewLineNo: Integer;
        SelectionType: Enum BeginEndEnum;
    begin
        if not Customer.Get(SalesHeader."Sell-to Customer No.") then
            exit;

        if SalesHeader."Beginning Invoice Text" <> '' then begin
            StdText.SetRange("No.", SalesHeader."Beginning Invoice Text");
            StdText.SetRange("Language Code", Customer."Language Code");
            SelectionType := SelectionType::"Begin";
            if StdText.FindSet() then
                repeat
                    Buffer.Init();
                    Buffer.Selection := SelectionType;
                    Buffer."No." := PostedInvoice."No.";
                    Buffer."customer no" := PostedInvoice."Sell-to Customer No.";
                    Buffer."Document Type" := SalesHeader."Document Type";
                    Buffer."Language code" := Customer."Language Code";
                    Buffer.Description := SalesHeader."Beginning Invoice Text";
                    Buffer.Text := StdText."Text";
                    Buffer."Line No." := GetNextLineNo(Buffer, Buffer."No.", Buffer."customer no", Buffer.Selection);
                    Buffer.Insert(true);
                until StdText.Next() = 0;
        end;

        if SalesHeader."Ending Invoice Text" <> '' then begin
            StdText.Reset();
            StdText.SetRange("No.", SalesHeader."Ending Invoice Text");
            StdText.SetRange("Language Code", Customer."Language Code");

            SelectionType := SelectionType::"End";
            if StdText.FindSet() then
                repeat
                    Buffer.Init();
                    Buffer.Selection := SelectionType;
                    Buffer."No." := PostedInvoice."No.";
                    Buffer."customer no" := PostedInvoice."Sell-to Customer No.";
                    //Buffer."Document Type" := SalesHeader."Document Type";
                    Buffer."Language code" := Customer."Language Code";
                    Buffer.Description := SalesHeader."Ending Invoice Text";
                    Buffer.Text := StdText."Text";
                    Buffer."Line No." := GetNextLineNo(Buffer, Buffer."No.", Buffer."customer no", Buffer.Selection);
                    Buffer.Insert(true);
                until StdText.Next() = 0;
        end;
    end;

    local procedure UpdateLastSoldPrices(PostedInvoice: Record "Sales Invoice Header")
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        LastSoldPrice: Record "LastSoldPrice";
    begin
        SalesInvoiceLine.SetRange("Document No.", PostedInvoice."No.");
        if SalesInvoiceLine.FindSet() then
            repeat
                LastSoldPrice.Init();
                LastSoldPrice.CustomerNo := SalesInvoiceLine."Sell-to Customer No.";
                LastSoldPrice.ItemNo := SalesInvoiceLine."No.";
                LastSoldPrice.ItemPrice := SalesInvoiceLine."Unit Price";
                LastSoldPrice.PostingDate := PostedInvoice."Posting Date";
                
                LastSoldPrice.Insert(true);
            until SalesInvoiceLine.Next() = 0;
    end;
}
