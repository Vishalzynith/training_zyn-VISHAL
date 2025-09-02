table 50163 Expense
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ExpenseID; Integer) { DataClassification = ToBeClassified; }
        field(2; Description; Text[50]) { DataClassification = ToBeClassified; }

        field(3; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Remaining: Decimal;
            begin
                Remaining := RemainingBudget();
                if Amount > Remaining then
                    Error('You cannot exceed the remaining monthly budget. Remaining: %1', Remaining);
            end;
        }

        field(4; Date; Date) { DataClassification = ToBeClassified; }

        field(5; Category; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = ExpenseCat.Name;
        }

        field(6; BudgetAmount; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Budget.Amount where(Category = field(Category)));
        }
    }

    keys
    {
        key(pk; ExpenseID) { Clustered = true; }
    }

    trigger OnInsert()
    begin
        if RemainingBudget() < 0 then
            Error('Cannot insert this expense because it exceeds the budget.');
    end;

    trigger OnModify()
    begin
        if RemainingBudget() < 0 then
            Error('Cannot modify this expense because it exceeds the budget.');
    end;

    procedure RemainingBudget(): Decimal
    var
        BudgetRec: Record Budget;
        ExpenseRec: Record Expense;
        PeriodExpense: Decimal;
        CurrentDate: Date;
    begin
        if Date <> 0D then
            CurrentDate := Date
        else
            CurrentDate := WorkDate();

        BudgetRec.Reset();
        BudgetRec.SetRange(Category, Category);
        BudgetRec.SetFilter(FromDate, '<=%1', CurrentDate);
        BudgetRec.SetFilter(ToDate, '>=%1', CurrentDate);

        if BudgetRec.FindFirst() then begin
            ExpenseRec.Reset();
            ExpenseRec.SetRange(Category, Category);
            ExpenseRec.SetRange("Date", BudgetRec.FromDate, BudgetRec.ToDate);

            if ExpenseRec.FindSet() then
                repeat
                    if ExpenseRec.ExpenseID <> ExpenseID then
                        PeriodExpense += ExpenseRec.Amount;
                until ExpenseRec.Next() = 0;

            exit(BudgetRec.Amount - PeriodExpense);
        end;

        exit(0);
    end;
}
