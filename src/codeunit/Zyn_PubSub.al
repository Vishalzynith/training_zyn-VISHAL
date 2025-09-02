codeunit 50127 "Customer Subscriber"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Customer Publisher", 'OnAfterNewCustomerCreated', '', false, false)]
    local procedure OnAfterNewCustCr(var Customer: Record Customer)
    begin
        Message('A new customer has been created: %1 :)', Customer.Name);
    end;
}

codeunit 50126 "Customer Event Trigger"
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterCustomerInsert(var Rec: Record Customer)
    var
        Publisher: Codeunit "Customer Publisher";
    begin
        Publisher.OnAfterNewCustomerCreated(Rec);
    end;
}
