codeunit 50103 Zyn_PurchasePostCheck
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure CheckApprovalStatus(PurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader."Approval Status" <> PurchaseHeader."Approval Status"::Approved then
            Error('You cannot post this Purchase Order because it is not approved.');
    end;
}
