table 50185 RecurringExpense
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; RecExpID; Integer) { DataClassification = ToBeClassified; }
        field(2; Amount; Decimal) { DataClassification = ToBeClassified;}
        field(3; Category; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = ExpenseCat.Name;
        }
        field(4; Cycle; Enum RecurringCycle)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if StartDate <> 0D then
                    NextCycle := GetNextCycleDate(StartDate, Cycle);
            end;
        }
        field(5; StartDate; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if Cycle <> Cycle::None then
                    NextCycle := GetNextCycleDate(StartDate, Cycle);
            end;
        }
        field(6; NextCycle; Date) { DataClassification = ToBeClassified; }
    }
    keys { key(PK; RecExpID) { Clustered = true; } }
    procedure GetNextCycleDate(CurrentDate: Date; Cycle: Enum RecurringCycle): Date
    begin
        case Cycle of
            Cycle::Weekly:
                exit(CalcDate('<+1W>', CurrentDate));
            Cycle::Monthly:
                exit(CalcDate('<+1M>', CurrentDate));
            Cycle::Quarterly:
                exit(CalcDate('<+3M>', CurrentDate));
            Cycle::HalfYearly:
                exit(CalcDate('<+6M>', CurrentDate));
            Cycle::Yearly:
                exit(CalcDate('<+1Y>', CurrentDate));
        end;
    end;

}