table 50172 Zyn_Income
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; IncomeID; Integer) { DataClassification = ToBeClassified; }
        field(2; Description; Text[50]) { DataClassification = ToBeClassified; }
        field(3; Amount; Decimal) { DataClassification = ToBeClassified; }
        field(4; Date; Date) { DataClassification = ToBeClassified; }
        field(5; Category; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Zyn_IncomeCategory.Name;
        }
    }

    keys { key(PK; IncomeID) { Clustered = true; } }
}
