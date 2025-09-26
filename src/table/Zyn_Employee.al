table 50276 Zyn_Employee
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Emp Id."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; role; Enum Zyn_Roles)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Department; Enum Zyn_DepartmentEnum)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Assigned Asset Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Zyn_EmpAssets where(EmpID = field("Emp Id."),
                                        Status = const(Assigned)));
        }

    }
    keys
    {
        key(PK; "Emp id.")
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        LeaveReq: Record Zyn_LeaveRequest;
        LeaveLog: Record Zyn_EmployeeLeaveLog;
    begin

        LeaveReq.Reset();
        LeaveReq.SetRange("Emp Id.", "Emp Id.");
        if LeaveReq.FindSet() then
            LeaveReq.DeleteAll();


        LeaveLog.Reset();
        LeaveLog.SetRange("Emp Id.", "Emp Id.");
        if LeaveLog.FindSet() then
            LeaveLog.DeleteAll();
    end;
}