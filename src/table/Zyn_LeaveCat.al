table 50271 Zyn_LeaveCategory
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "category name"; Enum Zyn_Category) { DataClassification = ToBeClassified; }
        field(2; "Leave Description"; Text[50]) { DataClassification = ToBeClassified; }
        field(3; "NO.of days allowed"; Integer) { DataClassification = ToBeClassified; }
    }

    keys
    {
        key(PK; "category name") { Clustered = true; }
    }

    trigger OnDelete()
    var
        LeaveReq: Record Zyn_LeaveRequest;
        LeaveLog: Record Zyn_EmployeeLeaveLog;
    begin

        LeaveReq.Reset();
        LeaveReq.SetRange(Category, "category name");
        if LeaveReq.FindSet() then
            LeaveReq.DeleteAll();


        LeaveLog.Reset();
        LeaveLog.SetRange(Category, "category name");
        if LeaveLog.FindSet() then
            LeaveLog.DeleteAll();
    end;
}
