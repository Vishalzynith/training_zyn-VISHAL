table 50173 IncomeCat
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; CategoryNo; Integer) { DataClassification = ToBeClassified; }
        field(2; Name; Code[20]) { DataClassification = ToBeClassified; }
        field(3; Description; Text[50]) { DataClassification = ToBeClassified; }
    }

    keys { key(PK; Name) { Clustered = true; } }
    fieldgroups
    {
        fieldgroup(DropDown; Name) { }
    }
}