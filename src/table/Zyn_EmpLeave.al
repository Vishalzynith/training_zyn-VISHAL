table 50280 Zyn_EmployeeLeaveLog
{
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
            Editable = false;
            DataClassification = SystemMetadata;
        }

        field(2; "Emp Id."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Category"; Enum Zyn_Category)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Leave From Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Leave To Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "No. of Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Emp Id.", "Entry No", Category)
        {
            Clustered = true;
        }
    }
}
