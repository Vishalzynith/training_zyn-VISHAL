codeunit 50101 "My Notification Actions"
{
    procedure OpenLeaveBalance(Notification: Notification)
    var
        LeavePage: Page "Leave Req List page";
    begin
        LeavePage.Run();
    end;
}
codeunit 50102 "My Notification Mgt."
{
    procedure ShowNoti()
    var
        Notification: Notification;
        LeaveRec: Record "LeaveRequest";
        EmplRec: Record "Employ Table";
    begin
        if LeaveRec.FindSet() then
            repeat
               Notification.Message :=
    StrSubstNo('Hello %1, current leave request status is %2',
               LeaveRec."Emp Id.",
               Format(LeaveRec.Status));
                Notification.Scope := NotificationScope::LocalScope;
                Notification.Send();
            until LeaveRec.Next() = 0;
    end;
}