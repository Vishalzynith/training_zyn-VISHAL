table 50278 "LeaveRequest"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Request No."; Code[20]) { DataClassification = ToBeClassified; }
        field(2; "Emp Id."; Code[20]) { DataClassification = ToBeClassified; }
        field(3; "Category"; Enum "category") { DataClassification = ToBeClassified; }
        field(4; "From Date"; Date) { DataClassification = ToBeClassified; }
        field(5; "To Date"; Date) { DataClassification = ToBeClassified; }
        field(6; "No.of days"; Integer) { Editable = false; }
        field(7; Status; Enum "Status") { DataClassification = ToBeClassified; }
        field(8; "Remaining Days"; Integer) { Editable = false; }
    }

    keys
    {
        key(PK; "Request No.") { Clustered = true; }
    }

    trigger OnDelete()
    var
        LeaveLog: Record "Employee Leave Log";
    begin
        
        LeaveLog.Reset();
        LeaveLog.SetRange("Emp Id.", "Emp Id.");
        LeaveLog.SetRange(Category, Category);
        LeaveLog.SetRange("Leave From Date", "From Date");
        LeaveLog.SetRange("Leave To Date", "To Date");
        if LeaveLog.FindSet() then
            LeaveLog.DeleteAll();
    end;
}
