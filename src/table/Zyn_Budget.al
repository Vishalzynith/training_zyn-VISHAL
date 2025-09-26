table 50182 Zyn_Budget
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; BudgetID; Integer) { DataClassification = ToBeClassified; }
        field(2; Category; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Zyn_ExpenseCategory.Name;
        }
        field(3; Amount; Decimal) { DataClassification = ToBeClassified; }
        field(4; FromDate; Date) { DataClassification = ToBeClassified; }
        field(5; ToDate; Date) { DataClassification = ToBeClassified; }
    }

    keys
    {
        key(PK; BudgetID) { Clustered = true; }
        //key(CategoryPeriod; Category, FromDate, ToDate) { Unique = true; }
    }
    procedure GetLastBudget(CategoryCode: Code[20]): Boolean
    var
        TempRec: Record Zyn_Budget;
    begin
        TempRec.Reset();
        TempRec.SetRange(Category, CategoryCode);
        if TempRec.FindLast() then begin
            Rec := TempRec;
            exit(true);
        end;
        exit(false);
    end;

    procedure GetBudgetForDate(CategoryName: Code[20]; CurrentDate: Date): Boolean
    begin
        Reset();
        SetRange(Category, CategoryName);
        SetFilter(FromDate, '<=%1', CurrentDate);
        SetFilter(ToDate, '>=%1', CurrentDate);
        exit(FindFirst());
    end;


}
