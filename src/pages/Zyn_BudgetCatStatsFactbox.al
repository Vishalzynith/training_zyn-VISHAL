page 50172 Zyn_BudgetCategoryFactbox
{
    PageType = CardPart;
    SourceTable = Zyn_ExpenseCategory;
    ApplicationArea = All;
    Caption = 'Category Budget Summary';
    layout
    {
        area(content)
        {
            cuegroup(Summary)
            {
                field(CurrentMonth; CurrentMonthBudget)
                {
                    Caption = 'Monthly Budget';
                    trigger OnDrillDown()
                    begin
                        OpenBudgetList(1);
                    end;
                }
                field(CurrentQuarter; CurrentQuarterBudget)
                {
                    Caption = 'Quarterly Budget';
                    trigger OnDrillDown()
                    begin
                        OpenBudgetList(2);
                    end;
                }
                field(CurrentHalfYear; CurrHalfYearBudget)
                {
                    Caption = 'Half-Yearly Budget';
                    trigger OnDrillDown()
                    begin
                        OpenBudgetList(3);
                    end;
                }
                field(CurrentYear; CurrYearBudget)
                {
                    Caption = 'Yearly Budget';
                    trigger OnDrillDown()
                    begin
                        OpenBudgetList(4);
                    end;
                }
                field(PrevYear; PreviousYearBudget)
                {
                    Caption = 'Previous Year Budget';
                    trigger OnDrillDown()
                    begin
                        OpenBudgetList(5);
                    end;
                }
            }
        }
    }

    var
        BudgetRecord: Record Zyn_Budget;
        CurrentMonthBudget: Decimal;
        CurrentQuarterBudget: Decimal;
        CurrHalfYearBudget: Decimal;
        CurrYearBudget: Decimal;
        PreviousYearBudget: Decimal;

    trigger OnAfterGetRecord()
    var
        StartDate: Date;
        EndDate: Date;
        CurrentMonth: Integer;
        CurrentQuarter: Integer;
        CurrentYear: Integer;
        PreviousYear: Integer;
        WorkDate: Date;
    begin
        Clear(CurrentMonthBudget);
        Clear(CurrentQuarterBudget);
        Clear(CurrHalfYearBudget);
        Clear(CurrYearBudget);
        Clear(PreviousYearBudget);

        WorkDate := WorkDate();
        CurrentYear := Date2DMY(WorkDate, 3);
        CurrentMonth := Date2DMY(WorkDate, 2);
        CurrentQuarter := (CurrentMonth - 1) div 3 + 1;
        PreviousYear := CurrentYear - 1;

        StartDate := DMY2Date(1, CurrentMonth, CurrentYear);
        EndDate := CalcDate('<CM>', StartDate);
        CurrentMonthBudget := GetBudgetTotal(Rec.Name, StartDate, EndDate);

        StartDate := DMY2Date(1, (CurrentQuarter - 1) * 3 + 1, CurrentYear);
        EndDate := CalcDate('<CQ>', StartDate);
        CurrentQuarterBudget := GetBudgetTotal(Rec.Name, StartDate, EndDate);

        if CurrentMonth <= 6 then begin
            StartDate := DMY2Date(1, 1, CurrentYear);
            EndDate := DMY2Date(30, 6, CurrentYear);
        end else begin
            StartDate := DMY2Date(1, 7, CurrentYear);
            EndDate := DMY2Date(31, 12, CurrentYear);
        end;
        CurrHalfYearBudget := GetBudgetTotal(Rec.Name, StartDate, EndDate);

        StartDate := DMY2Date(1, 1, CurrentYear);
        EndDate := DMY2Date(31, 12, CurrentYear);
        CurrYearBudget := GetBudgetTotal(Rec.Name, StartDate, EndDate);

        StartDate := DMY2Date(1, 1, PreviousYear);
        EndDate := DMY2Date(31, 12, PreviousYear);
        PreviousYearBudget := GetBudgetTotal(Rec.Name, StartDate, EndDate);
    end;

    local procedure GetBudgetTotal(CategoryName: Code[20]; StartDate: Date; EndDate: Date): Decimal
    var
        BudgetRecord: Record Zyn_Budget;
    begin
        BudgetRecord.Reset();
        BudgetRecord.SetRange(Category, CategoryName);
        BudgetRecord.SetFilter(FromDate, '<=%1', EndDate);
        BudgetRecord.SetFilter(ToDate, '>=%1', StartDate);
        BudgetRecord.CalcSums(Amount);
        exit(BudgetRecord.Amount);
    end;

    local procedure OpenBudgetList(d: Integer)
    var
        BudgetList: Page Zyn_BudgetList;
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
        BudgetRecord.Reset();
        BudgetRecord.SetRange("Category", Rec.Name);
        BudgetRecord.SetFilter(FromDate, '<=%1', EndDate);
        BudgetRecord.SetFilter(ToDate, '>=%1', StartDate);

        BudgetList.SetTableView(BudgetRecord);
        BudgetList.Run();
    end;
}
