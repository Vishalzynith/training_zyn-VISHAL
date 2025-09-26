codeunit 50116 Zyn_CompanyChange
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::Zyn_CompanyChangePublisher, 'onaddcustomercreated', '', false, false)]
    local procedure OnCustomerCreated("customer rec": Record Customer)
    var
        TargetCustomer: Record Customer;
        CompanyName: Text;
    begin
        CompanyName := 'VishalZynith';
        if TargetCustomer.ChangeCompany(CompanyName) then begin
            if not TargetCustomer.Get("customer rec"."No.") then begin
                TargetCustomer.Init();
                TargetCustomer.TransferFields("customer rec");
                TargetCustomer.Insert();
            end;
        end else
            Error('Unable to access target company: %1', CompanyName);
    end;
}