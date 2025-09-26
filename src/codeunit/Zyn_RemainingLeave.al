codeunit 50281 Zyn_LeaveManagement
{
    procedure ApproveLeaveRequest(var LeaveReq: Record Zyn_LeaveRequest)
    var
        LeaveCategory: Record Zyn_LeaveCategory;
        LeaveLog: Record Zyn_EmployeeLeaveLog;
        DaysTaken: Integer;
        TotalUsed: Integer;
    begin
        LeaveReq.TestField("Emp Id.");
        LeaveReq.TestField(Category);
        LeaveReq.TestField("From Date");
        LeaveReq.TestField("To Date");

        DaysTaken := LeaveReq."To Date" - LeaveReq."From Date" + 1;
        if DaysTaken <= 0 then
            Error('Invalid leave period. To Date must be after From Date.');

        if not LeaveCategory.Get(LeaveReq.Category) then
            Error('Leave category %1 not found.', LeaveReq.Category);

        TotalUsed := 0;
        LeaveLog.Reset();
        LeaveLog.SetRange("Emp Id.", LeaveReq."Emp Id.");
        LeaveLog.SetRange(Category, LeaveReq.Category);
        if LeaveLog.FindSet() then
            repeat
                TotalUsed += LeaveLog."No. of Days";
            until LeaveLog.Next() = 0;

        if (TotalUsed + DaysTaken) > LeaveCategory."NO.of days allowed" then
            Error(
              'Leave request exceeds allowed days (%1) for category %2. Currently used: %3, Requested: %4',
              LeaveCategory."NO.of days allowed", LeaveReq.Category, TotalUsed, DaysTaken);

        LeaveLog.Init();
        LeaveLog."Entry No" := 0;
        LeaveLog."Emp Id." := LeaveReq."Emp Id.";
        LeaveLog."Category" := LeaveReq.Category;
        LeaveLog."Leave From Date" := LeaveReq."From Date";
        LeaveLog."Leave To Date" := LeaveReq."To Date";
        LeaveLog."No. of Days" := DaysTaken;
        LeaveLog.Insert();

        LeaveReq."No.of days" := DaysTaken;
        LeaveReq."Remaining Days" := LeaveCategory."NO.of days allowed" - (TotalUsed + DaysTaken);
        LeaveReq.Status := LeaveReq.Status::Approved;
        LeaveReq.Modify(true);
    end;
}
