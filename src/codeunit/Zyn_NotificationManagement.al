codeunit 50102 Zyn_NotificationManagement
{
    procedure ShowNoti()
    var
        Notification: Notification;
        LeaveRecord: Record Zyn_LeaveRequest;
        EmployeeRecord: Record Zyn_Employee;
    begin
        if LeaveRecord.FindSet() then
            repeat
                Notification.Message :=
     StrSubstNo('Hello %1, current leave request status is %2',
                LeaveRecord."Emp Id.",
                Format(LeaveRecord.Status));
                Notification.Scope := NotificationScope::LocalScope;
                Notification.Send();
            until LeaveRecord.Next() = 0;
    end;
}