codeunit 50126 Zyn_CustomerEventTrigger
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterCustomerInsert(var Rec: Record Customer)
    var
        Publisher: Codeunit Zyn_CustomerPublisher;
    begin
        Publisher.OnAfterNewCustomerCreated(Rec);
    end;
}
