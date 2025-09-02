table 50109 Technician
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Dept"; Enum "Department Enum")
        {
            DataClassification = CustomerContent;
        }
        field(5; "Problem Count"; Integer)
        {
            Caption = 'Problem Count';
            FieldClass = FlowField;
            CalcFormula = count(Problems where(Technician = field(ID)));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
    }
}