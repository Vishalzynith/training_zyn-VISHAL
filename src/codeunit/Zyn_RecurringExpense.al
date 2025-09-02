codeunit 50188 "Recurring Expense Processor"
{
    Subtype = Normal;
    trigger OnRun()
    begin
        ProcessRecurringExpenses();
    end;
    local procedure ProcessRecurringExpenses()
    var
        RecExp: Record RecurringExpense;
        Exp: Record Expense;
    begin
        RecExp.Reset();
        if RecExp.FindSet() then
            repeat
                if (RecExp.NextCycle <> 0D) and (RecExp.NextCycle <= WorkDate()) then begin
                    Exp.Init();
                    Exp.ExpenseID := GetNextExpenseID();
                    Exp.Description := 'Recurring Expense - ' + RecExp.Category;
                    
                    Exp.Validate(Category, RecExp.Category);
                    Exp.Validate("Date", RecExp.NextCycle);
                    Exp.Validate(Amount, RecExp.Amount);

                    Exp.Insert(true);

                    RecExp.NextCycle := RecExp.GetNextCycleDate(RecExp.NextCycle, RecExp.Cycle);
                    RecExp.Modify(true);
                end;
            until RecExp.Next() = 0;
    end;

    local procedure GetNextExpenseID(): Integer
    var
        Exp: Record Expense;
    begin
        if Exp.FindLast() then
            exit(Exp.ExpenseID + 1)
        else
            exit(1);
    end;
}
