table 50162 IndexCalc
{
    fields
    {
        field(1; "Code"; Code[20]){}
        field(2; "Entry No"; Integer){}
        field(3; "Year"; Integer){}
        field(4; "Value"; Decimal){}
    }
    keys{key(PK; Code, "Entry No"){Clustered = true;}}    
}