codeunit 50101 Zyn_NotificationActions
{
    procedure OpenLeaveBalance(Notification: Notification)
    var
        LeavePage: Page Zyn_LeaveRequestList;
    begin
        LeavePage.Run();
    end;
}
