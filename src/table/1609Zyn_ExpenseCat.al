table 50183 Zyn_ExpenseCategory
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; CategoryID; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; EmpID; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Zyn_Employee."Emp Id.";
            Caption = 'Employee ID';
        }
        field(3; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; SubType; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Limit; Decimal)
        {
            Caption = 'Limit';
            DataClassification = ToBeClassified;
        }
        field(7; "ClaimedAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula =
                Sum("Zyn_ExpenseClaim".Amount WHERE(
                    EmpID = FIELD(EmpID),
                    CategoryID = FIELD(CategoryID),
                    Status = CONST(Approved)
                ));
            Editable = false;
            Caption = 'Used Amount';
        }
    }
    keys
    {
        key(PK; CategoryID)
        {
            Clustered = true;
        }
        key(Uniq; EmpID, Code, Name, SubType)
        {
            Unique = true;
        }
    }
    trigger OnInsert()
    begin
        if Limit <= 0 then
            Error('Limit must be set and greater than 0');
    end;

    trigger OnModify()
    begin
        if Limit <= 0 then
            Error('Limit must be set and greater than 0');
    end;
}
