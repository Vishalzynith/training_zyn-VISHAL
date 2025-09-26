codeunit 50127 Zyn_CustomerSubscriber
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::Zyn_CustomerPublisher, 'OnAfterNewCustomerCreated', '', false, false)]
    local procedure OnAfterNewCustCr(var Customer: Record Customer)
    begin
        Message('A new customer has been created: %1 :)', Customer.Name);
    end;
}

