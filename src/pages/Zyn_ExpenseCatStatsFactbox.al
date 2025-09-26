page 50171 Zyn_ExpenseCategoryFactbox
{
    PageType = CardPart;
    SourceTable = Zyn_ExpenseCategory;
    ApplicationArea = All;
    Caption = 'Category Expense Summary';

    layout
    {
        area(content)
        {
            field(RemainingBudget; CategoryRemainingBudget)
            {
                Caption = 'Remaining Budget';
            }
            cuegroup(Summary)
            {
                field(CurrentMonth; CurrentMonthExpense)
                {
                    Caption = 'Current Month';
                    trigger OnDrillDown()
                    begin
                        OpenExpenseList(1);
                    end;
                }
                field(CurrentQuarter; CurrentQuarterExpense)
                {
                    Caption = 'Current Quarter';
                    trigger OnDrillDown()
                    begin
                        OpenExpenseList(2);
                    end;
                }
                field(CurrentHalfYear; CurrentHalfYearExpense)
                {
                    Caption = 'Current Half-Year';
                    trigger OnDrillDown()
                    begin
                        OpenExpenseList(3);
                    end;
                }
                field(CurrentYear; CurrentYearExpense)
                {
                    Caption = 'Current Year';
                    trigger OnDrillDown()
                    begin
                        OpenExpenseList(4);
                    end;
                }
                field(PrevYear; PreviousYearExpense)
                {
                    Caption = 'Previous Year';
                    trigger OnDrillDown()
                    begin
                        OpenExpenseList(5);
                    end;
                }
            }
        }
    }
    var
        ExpenseRecord: Record Zyn_Expense;
        CurrentMonthExpense: Decimal;
        CurrentQuarterExpense: Decimal;
        CurrentHalfYearExpense: Decimal;
        CurrentYearExpense: Decimal;
        PreviousYearExpense: Decimal;
        CategoryRemainingBudget: Decimal;
        BudgetRecord: Record Zyn_Budget;
    trigger OnAfterGetRecord()
    var
        StartDate: Date;
        EndDate: Date;
        CurrentMonth: Integer;
        CurrentQuarter: Integer;
        CurrYear: Integer;
        WorkDate: Date;
        PreviousYear: Integer;
    begin
        Clear(CurrentMonthExpense);
        Clear(CurrentQuarterExpense);
        Clear(CurrentHalfYearExpense);
        Clear(CurrentYearExpense);
        Clear(PreviousYearExpense);
        Clear(CategoryRemainingBudget);

        WorkDate := WorkDate();
        CurrYear := Date2DMY(WorkDate, 3);
        CurrentMonth := Date2DMY(WorkDate, 2);
        CurrentQuarter := (CurrentMonth - 1) div 3 + 1;
        PreviousYear := CurrYear - 1;

        if BudgetRecord.GetBudgetForDate(Rec.Name, WorkDate) then begin
            ExpenseRecord.Reset();
            ExpenseRecord.SetRange(Category, Rec.Name);
            ExpenseRecord.SetRange(Date, BudgetRecord.FromDate, BudgetRecord.ToDate);
            ExpenseRecord.CalcSums(Amount);

            CategoryRemainingBudget := BudgetRecord.Amount - ExpenseRecord.Amount;
        end;

        StartDate := DMY2Date(1, 1, PreviousYear);
        EndDate := DMY2Date(31, 12, PreviousYear);
        PreviousYearExpense := GetExpenseTotal(Rec.Name, StartDate, EndDate);

        StartDate := DMY2Date(1, CurrentMonth, CurrYear);
        EndDate := CalcDate('<CM>', StartDate);
        CurrentMonthExpense := GetExpenseTotal(Rec.Name, StartDate, EndDate);

        StartDate := DMY2Date(1, (CurrentQuarter - 1) * 3 + 1, CurrYear);
        EndDate := CalcDate('<CQ>', StartDate);
        CurrentQuarterExpense := GetExpenseTotal(Rec.Name, StartDate, EndDate);

        if CurrentMonth <= 6 then begin
            StartDate := DMY2Date(1, 1, CurrYear);
            EndDate := DMY2Date(30, 6, CurrYear);
        end else begin
            StartDate := DMY2Date(1, 7, CurrYear);
            EndDate := DMY2Date(31, 12, CurrYear);
        end;
        CurrentHalfYearExpense := GetExpenseTotal(Rec.Name, StartDate, EndDate);

        StartDate := DMY2Date(1, 1, CurrYear);
        EndDate := DMY2Date(31, 12, CurrYear);
        CurrentYearExpense := GetExpenseTotal(Rec.Name, StartDate, EndDate);
    end;

    local procedure GetExpenseTotal(CategoryName: Code[20]; StartDate: Date; EndDate: Date): Decimal
    begin
        ExpenseRecord.Reset();
        ExpenseRecord.SetRange("Category", CategoryName);
        ExpenseRecord.SetRange(Date, StartDate, EndDate);
        ExpenseRecord.CalcSums(Amount);
        exit(ExpenseRecord.Amount);
    end;

    local procedure OpenExpenseList(d: Integer)
    var
        ExpenseList: Page Zyn_ExpenseList;
        StartDate: Date;
        EndDate: Date;
        CurrentMonth: Integer;
        CurrentQuarter: Integer;
        CurrentYear: Integer;
        PreviousYear: Integer;
        WorkDate: Date;
    begin
        WorkDate := WorkDate();
        CurrentYear := Date2DMY(WorkDate, 3);
        CurrentMonth := Date2DMY(WorkDate, 2);
        CurrentQuarter := (CurrentMonth - 1) div 3 + 1;
        PreviousYear := CurrentYear - 1;
        case d of
            1:
                begin
                    StartDate := DMY2Date(1, CurrentMonth, CurrentYear);
                    EndDate := CalcDate('<CM>', StartDate);
                end;
            2:
                begin
                    StartDate := DMY2Date(1, (CurrentQuarter - 1) * 3 + 1, CurrentYear);
                    EndDate := CalcDate('<CQ>', StartDate);
                end;
            3:
                begin
                    if CurrentMonth <= 6 then begin
                        StartDate := DMY2Date(1, 1, CurrentYear);
                        EndDate := DMY2Date(30, 6, CurrentYear);
                    end else begin
                        StartDate := DMY2Date(1, 7, CurrentYear);
                        EndDate := DMY2Date(31, 12, CurrentYear);
                    end;
                end;
            4:
                begin
                    StartDate := DMY2Date(1, 1, CurrentYear);
                    EndDate := DMY2Date(31, 12, CurrentYear);
                end;
            5:
                begin
                    StartDate := DMY2Date(1, 1, PreviousYear);
                    EndDate := DMY2Date(31, 12, PreviousYear);
                end;
        end;
        ExpenseRecord.Reset();
        ExpenseRecord.SetRange("Category", Rec.Name);
        ExpenseRecord.SetRange(Date, StartDate, EndDate);
        ExpenseList.SetTableView(ExpenseRecord);
        ExpenseList.Run();
    end;
}
