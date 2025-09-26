codeunit 50188 Zyn_RecurringExpenseProcessor
{
    Subtype = Normal;
    trigger OnRun()
    begin
        ProcessRecurringExpenses();
    end;

    local procedure ProcessRecurringExpenses()
    var
        RecurringExpense: Record Zyn_RecurringExpense;
        Expense: Record Zyn_Expense;
    begin
        RecurringExpense.Reset();
        if RecurringExpense.FindSet() then
            repeat
                if (RecurringExpense.NextCycle <> 0D) and (RecurringExpense.NextCycle <= WorkDate()) then begin
                    Expense.Init();
                    Expense.ExpenseID := GetNextExpenseID();
                    Expense.Description := 'Recurring Expense - ' + RecurringExpense.Category;

                    Expense.Validate(Category, RecurringExpense.Category);
                    Expense.Validate("Date", RecurringExpense.NextCycle);
                    Expense.Validate(Amount, RecurringExpense.Amount);

                    Expense.Insert(true);

                    RecurringExpense.NextCycle := RecurringExpense.GetNextCycleDate(RecurringExpense.NextCycle, RecurringExpense.Cycle);
                    RecurringExpense.Modify(true);
                end;
            until RecurringExpense.Next() = 0;
    end;

    local procedure GetNextExpenseID(): Integer
    var
        Expense: Record Zyn_Expense;
    begin
        if Expense.FindLast() then
            exit(Expense.ExpenseID + 1)
        else
            exit(1);
    end;
}
