table 50143 Subpageext
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            //AutoIncrement = true;
        }
        field(2; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "customer no"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Document Type"; Enum "Sales Document Type")
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Sales Header"."Document Type" where("Document Type" = const(Invoice));
        }
        field(5; "Language code"; Code[100])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Extended Text Header"."Language Code";
        }
        field(6; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Text"; Text[250])
        {
            DataClassification = ToBeClassified;
 
        }
        field(8; "Bold"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Italics"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Underlined"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "selection"; enum BeginEndEnum)
        {
            DataClassification = ToBeClassified;
            Caption = 'Selection';
        }
    }
    keys
    {
        key(PK; "No.", "Line No.", "Language code", selection, "Document Type")
        {
            Clustered = true;
        }
    }
}
 