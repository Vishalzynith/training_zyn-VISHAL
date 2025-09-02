table 50123 "Modify Log"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "Customer No"; Code[100])
        {
            DataClassification = SystemMetadata;
            TableRelation = Customer."No.";
        }
        field(3; "Field Name"; Text[100])
        {
            DataClassification = SystemMetadata;
        }
        field(4; "Prev Value"; Text[250])
        {
            DataClassification = SystemMetadata;
        }
        field(5; "Updated Value"; Text[250])
        {
            DataClassification = SystemMetadata;
        }
        field(6; "Modified By"; Text[50])
        {
            DataClassification = SystemMetadata;
        }

    }

    keys
    {
        key(PK; "Entry No", "Customer No")
        {
            Clustered = true;
        }
    }

}
