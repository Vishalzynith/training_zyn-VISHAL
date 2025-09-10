codeunit 50161 Zyn_SubscriptionRenewal
{
    Subtype = Normal;

    trigger OnRun()
    var
        SubsRecord: Record Subscription;
        Remainder: Date;
    begin
        Remainder := WorkDate() + 15;
        SubsRecord.Reset();
        SubsRecord.SetRange(Status, SubsRecord.Status::Active);
        SubsRecord.SetRange(EndDate, Remainder);
        SubsRecord.SetRange("Reminder Sent", false);

        if SubsRecord.FindSet() then
            repeat
                SendReminder(SubsRecord);
                SubsRecord."Reminder Sent" := true;
                SubsRecord.Modify();
            until SubsRecord.Next() = 0;
    end;

    procedure SendReminder(SubsRecord: Record Subscription)
    var
        Notif: Notification;
        Customer: Record Customer;
    begin
        Clear(Notif);

        if Customer.Get(SubsRecord.CustomerID) then begin
            Notif.Id := CreateGuid();
            Notif.Message := StrSubstNo(
                'Reminder: Subscription %1 for Customer %2 will expire on %3. Please renew!.',
                SubsRecord.SubID,
                Customer.Name,
                Format(SubsRecord.EndDate));
            Notif.Scope := NotificationScope::LocalScope;
            Notif.Send();
        end;
    end;
}
