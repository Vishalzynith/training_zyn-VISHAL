page 50171 ExpenseCatStatsFactbox
{
    PageType = CardPart;
    SourceTable = "ExpenseCat";
    ApplicationArea = All;
    Caption = 'Category Expense Summary';

    layout
    {
        area(content)
        {
            field(RemainingBudget; CatRemainingBudget)
            {
                ApplicationArea = All;
                Caption = 'Remaining Budget';
            }
            cuegroup(Summary)
            {
                field(CurrentMonth; CurrMonthExpense)
                {
                    ApplicationArea = All;
                    Caption = 'Current Month';
                    trigger OnDrillDown()
                    begin
                        OpenExpenseList(1);
                    end;
                }
                field(CurrentQuarter; CurrQuarterExpense)
                {
                    ApplicationArea = All;
                    Caption = 'Current Quarter';
                    trigger OnDrillDown()
                    begin
                        OpenExpenseList(2);
                    end;
                }
                field(CurrentHalfYear; CurrHalfYearExpense)
                {
                    ApplicationArea = All;
                    Caption = 'Current Half-Year';
                    trigger OnDrillDown()
                    begin
                        OpenExpenseList(3);
                    end;
                }
                field(CurrentYear; CurrYearExpense)
                {
                    ApplicationArea = All;
                    Caption = 'Current Year';
                    trigger OnDrillDown()
                    begin
                        OpenExpenseList(4);
                    end;
                }
                field(PrevYear; PrevYearExpense)
                {
                    ApplicationArea = All;
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
        ExpenseRec: Record "Expense";
        CurrMonthExpense: Decimal;
        CurrQuarterExpense: Decimal;
        CurrHalfYearExpense: Decimal;
        CurrYearExpense: Decimal;
        PrevYearExpense: Decimal;
        CatRemainingBudget: Decimal;
        BudgetRec: Record Budget;

    trigger OnAfterGetRecord()
    var
        StartDate: Date;
        EndDate: Date;
        CurrMonth: Integer;
        CurrQuarter: Integer;
        CurrYear: Integer;
        WorkDt: Date;
        PrevYear: Integer;
    begin
        Clear(CurrMonthExpense);
        Clear(CurrQuarterExpense);
        Clear(CurrHalfYearExpense);
        Clear(CurrYearExpense);
        Clear(PrevYearExpense);
        Clear(CatRemainingBudget);

        WorkDt := WorkDate();
        CurrYear := Date2DMY(WorkDt, 3);
        CurrMonth := Date2DMY(WorkDt, 2);
        CurrQuarter := (CurrMonth - 1) div 3 + 1;
        PrevYear := CurrYear - 1;

        if BudgetRec.GetBudgetForDate(Rec.Name, WorkDt) then begin
            ExpenseRec.Reset();
            ExpenseRec.SetRange(Category, Rec.Name);
            ExpenseRec.SetRange(Date, BudgetRec.FromDate, BudgetRec.ToDate);
            ExpenseRec.CalcSums(Amount);

            CatRemainingBudget := BudgetRec.Amount - ExpenseRec.Amount;
        end;

        StartDate := DMY2Date(1, 1, PrevYear);
        EndDate := DMY2Date(31, 12, PrevYear);
        PrevYearExpense := GetExpenseTotal(Rec.Name, StartDate, EndDate);

        StartDate := DMY2Date(1, CurrMonth, CurrYear);
        EndDate := CalcDate('<CM>', StartDate);
        CurrMonthExpense := GetExpenseTotal(Rec.Name, StartDate, EndDate);

        StartDate := DMY2Date(1, (CurrQuarter - 1) * 3 + 1, CurrYear);
        EndDate := CalcDate('<CQ>', StartDate);
        CurrQuarterExpense := GetExpenseTotal(Rec.Name, StartDate, EndDate);

        if CurrMonth <= 6 then begin
            StartDate := DMY2Date(1, 1, CurrYear);
            EndDate := DMY2Date(30, 6, CurrYear);
        end else begin
            StartDate := DMY2Date(1, 7, CurrYear);
            EndDate := DMY2Date(31, 12, CurrYear);
        end;
        CurrHalfYearExpense := GetExpenseTotal(Rec.Name, StartDate, EndDate);

        StartDate := DMY2Date(1, 1, CurrYear);
        EndDate := DMY2Date(31, 12, CurrYear);
        CurrYearExpense := GetExpenseTotal(Rec.Name, StartDate, EndDate);
    end;

    local procedure GetExpenseTotal(CategoryName: Code[20]; StartDate: Date; EndDate: Date): Decimal
    begin
        ExpenseRec.Reset();
        ExpenseRec.SetRange("Category", CategoryName);
        ExpenseRec.SetRange(Date, StartDate, EndDate);
        ExpenseRec.CalcSums(Amount);
        exit(ExpenseRec.Amount);
    end;

    local procedure OpenExpenseList(d: Integer)
    var
        ExpenseList: Page "ExpenseList";
        StartDate: Date;
        EndDate: Date;
        CurrMonth: Integer;
        CurrQuarter: Integer;
        CurrYear: Integer;
        PrevYear: Integer;
        WorkDt: Date;
    begin
        WorkDt := WorkDate();
        CurrYear := Date2DMY(WorkDt, 3);
        CurrMonth := Date2DMY(WorkDt, 2);
        CurrQuarter := (CurrMonth - 1) div 3 + 1;
        PrevYear := CurrYear - 1;

        case d of
            1:
                begin
                    StartDate := DMY2Date(1, CurrMonth, CurrYear);
                    EndDate := CalcDate('<CM>', StartDate);
                end;
            2:
                begin
                    StartDate := DMY2Date(1, (CurrQuarter - 1) * 3 + 1, CurrYear);
                    EndDate := CalcDate('<CQ>', StartDate);
                end;
            3:
                begin
                    if CurrMonth <= 6 then begin
                        StartDate := DMY2Date(1, 1, CurrYear);
                        EndDate := DMY2Date(30, 6, CurrYear);
                    end else begin
                        StartDate := DMY2Date(1, 7, CurrYear);
                        EndDate := DMY2Date(31, 12, CurrYear);
                    end;
                end;
            4:
                begin
                    StartDate := DMY2Date(1, 1, CurrYear);
                    EndDate := DMY2Date(31, 12, CurrYear);
                end;
            5:
                begin
                    StartDate := DMY2Date(1, 1, PrevYear);
                    EndDate := DMY2Date(31, 12, PrevYear);
                end;
        end;

        ExpenseRec.Reset();
        ExpenseRec.SetRange("Category", Rec.Name);
        ExpenseRec.SetRange(Date, StartDate, EndDate);
        ExpenseList.SetTableView(ExpenseRec);
        ExpenseList.Run();
    end;
}
