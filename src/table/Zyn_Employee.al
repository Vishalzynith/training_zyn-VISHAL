table 50276 "Employ Table"
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
        field(3; role; Enum Roles)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Department; Enum "Department Enum")
        {
            DataClassification = ToBeClassified;
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
        LeaveReq: Record "LeaveRequest";
        LeaveLog: Record "Employee Leave Log";
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