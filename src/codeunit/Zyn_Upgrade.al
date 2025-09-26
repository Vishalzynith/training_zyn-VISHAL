codeunit 50135 Zyn_UpgradeLastSoldPrice
{
    Subtype = Upgrade;
    trigger OnUpgradePerCompany()
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesInvHeader: Record "Sales Invoice Header";
        LastSoldPrice: Record Zyn_LastSoldPrice;
        UpgradeTag:Codeunit "Upgrade Tag";
    begin
        if UpgradeTag.HasUpgradeTag('LastSoldPrice2') then begin
        if SalesInvoiceLine.FindSet() then
            repeat
                if SalesInvHeader.Get(SalesInvoiceLine."Document No.") then begin
                    LastSoldPrice.Reset();
                    LastSoldPrice.SetRange("CustomerNo", SalesInvoiceLine."Sell-to Customer No.");
                    LastSoldPrice.SetRange(ItemNo, SalesInvoiceLine."No.");
 
                    if LastSoldPrice.FindFirst() then begin
                        LastSoldPrice.ItemPrice := SalesInvoiceLine."Unit Price";
                        LastSoldPrice.PostingDate := SalesInvHeader."Posting Date";
                        LastSoldPrice.Modify(true);
                    end else begin
                        LastSoldPrice.Init();
                        LastSoldPrice."CustomerNo" := SalesInvoiceLine."Sell-to Customer No.";
                        LastSoldPrice.ItemNo:= SalesInvoiceLine."No.";
                        LastSoldPrice.ItemPrice := SalesInvoiceLine."Unit Price";
                        LastSoldPrice.PostingDate:= SalesInvHeader."Posting Date";
                        
                        LastSoldPrice.Insert(true);
                    end;
                end;
            until SalesInvoiceLine.Next() = 0;
            UpgradeTag.SetUpgradeTag('LastSoldPrice2');
        end;
    end;
}
 
 