codeunit 50139 Zyn_LoyalPointsUpdate
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', true, true)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean; var CalledBy: Integer)
    var
        CustomerRecord: Record Customer;
    begin
        if (SalesHeader."Document Type" in [SalesHeader."Document Type"::Invoice, SalesHeader."Document Type"::Order]) then begin
            if CustomerRecord.Get(SalesHeader."Sell-to Customer No.") then begin
                if CustomerRecord."Loyalty Points Used" >= CustomerRecord."Loyalty Points Allowed" then
                    Error('Cannot post invoice. Loyalty points limit (%1) reached for this customer.', CustomerRecord."Loyalty Points Allowed");
            end;
        end;
    end;
}
codeunit 50140 Zyn_LoyalPointsUpdation
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', true, true)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean; PreviewMode: Boolean)
    var
        CustomerRecord: Record Customer;
    begin
        if (SalesHeader."Document Type" in [SalesHeader."Document Type"::Invoice, SalesHeader."Document Type"::Order]) then begin

            if CustomerRecord.Get(SalesHeader."Sell-to Customer No.") then begin
                CustomerRecord."Loyalty Points Used" += 10;
                CustomerRecord.Modify();
            end;
        end;
    end;
}
