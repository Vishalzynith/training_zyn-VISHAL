table 50164 Zyn_Expense_Category
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