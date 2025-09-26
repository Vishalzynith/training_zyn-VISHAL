
table 50111 Zyn_FieldLookupBuffer
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer) { AutoIncrement = true; }
        field(2; "Field Name"; Text[100]) { }
    }

    keys
    {
        key(PK; ID, "Field Name") { Clustered = true; }
    }
}
