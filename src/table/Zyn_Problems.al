table 50110 Zyn_Problems
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry Number"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
            Caption = 'Problem ID';
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
        }
        field(3; Problem; Enum Zyn_ProblemEnum)
        {
            DataClassification = CustomerContent;
            Caption = 'Problem Description';
        }
        field(4; Dept; Enum Zyn_DepartmentEnum)
        {
            DataClassification = CustomerContent;
            Caption = 'Specify the department';
        }

        field(5; Technician; Code[10])
        {
            Caption = 'Technician';
            TableRelation = Zyn_Technician.ID where(Dept = field(Dept));
        }
        field(6; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Please describe the problem';
        }
        field(7; Date; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Select Date';
        }

    }
    keys
    {
        key(PK; "Entry Number", "Customer No.")
        {
            Clustered = true;
        }
    }
}