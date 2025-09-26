page 50181 Zyn_IncomeCategoryFactbox
{
    PageType = CardPart;
    SourceTable = Zyn_IncomeCategory;
    ApplicationArea = All;
    Caption = 'Category Income Summary';
    layout
    {
        area(content)
        {
            cuegroup(Summary)
            {
                field(CurrentMonth; CurrentMonthIncome)
                {
                    Caption = 'Current Month';
                    trigger OnDrillDown()
                    begin
                        OpenIncomeList(1);
                    end;
                }
                field(CurrentQuarter; CurrentQuarterIncome)
                {
                    Caption = 'Current Quarter';
                    trigger OnDrillDown()
                    begin
                        OpenIncomeList(2);
                    end;
                }
                field(CurrentHalfYear; CurrentHalfYearIncome)
                {
                    Caption = 'Current Half-Year';
                    trigger OnDrillDown()
                    begin
                        OpenIncomeList(3);
                    end;
                }
                field(CurrentYear; CurrentYearIncome)
                {
                    Caption = 'Current Year';
                    trigger OnDrillDown()
                    begin
                        OpenIncomeList(4);
                    end;
                }
                field(PrevYear; PreviousYearIncome)
                {
                    Caption = 'Previous Year';
                    trigger OnDrillDown()
                    begin
                        OpenIncomeList(5);
                    end;
                }
            }
        }
    }
    var
        IncomeRecord: Record Zyn_Income;
        CurrentMonthIncome: Decimal;
        CurrentQuarterIncome: Decimal;
        CurrentHalfYearIncome: Decimal;
        CurrentYearIncome: Decimal;
        PreviousYearIncome: Decimal;
    trigger OnAfterGetRecord()
    var
        StartDate: Date;
        EndDate: Date;
        CurrentMonth: Integer;
        CurrQuarter: Integer;
        CurrentYear: Integer;
        WorkDate: Date;
        PreviousYear: Integer;
    begin
        Clear(CurrentMonthIncome);
        Clear(CurrentQuarterIncome);
        Clear(CurrentHalfYearIncome);
        Clear(CurrentYearIncome);
        Clear(PreviousYearIncome);
        WorkDate := WorkDate();
        CurrentYear := Date2DMY(WorkDate, 3);
        CurrentMonth := Date2DMY(WorkDate, 2);
        CurrQuarter := (CurrentMonth - 1) div 3 + 1;
        PreviousYear := CurrentYear - 1;

        StartDate := DMY2Date(1, 1, PreviousYear);
        EndDate := DMY2Date(31, 12, PreviousYear);
        PreviousYearIncome := GetIncomeTotal(Rec.Name, StartDate, EndDate);

        StartDate := DMY2Date(1, CurrentMonth, CurrentYear);
        EndDate := CalcDate('<CM>', StartDate);
        CurrentMonthIncome := GetIncomeTotal(Rec.Name, StartDate, EndDate);

        StartDate := DMY2Date(1, (CurrQuarter - 1) * 3 + 1, CurrentYear);
        EndDate := CalcDate('<CQ>', StartDate);
        CurrentQuarterIncome := GetIncomeTotal(Rec.Name, StartDate, EndDate);
        if CurrentMonth <= 6 then
            StartDate := DMY2Date(1, 1, CurrentYear)
        else
            StartDate := DMY2Date(1, 7, CurrentYear);

        if CurrentMonth <= 6 then
            EndDate := DMY2Date(30, 6, CurrentYear)
        else
            EndDate := DMY2Date(31, 12, CurrentYear);

        CurrentHalfYearIncome := GetIncomeTotal(Rec.Name, StartDate, EndDate);

        StartDate := DMY2Date(1, 1, CurrentYear);
        EndDate := DMY2Date(31, 12, CurrentYear);
        CurrentYearIncome := GetIncomeTotal(Rec.Name, StartDate, EndDate);
    end;

    local procedure GetIncomeTotal(CategoryName: Code[20]; StartDate: Date; EndDate: Date): Decimal
    begin
        IncomeRecord.Reset();
        IncomeRecord.SetRange("Category", CategoryName);
        IncomeRecord.SetRange(Date, StartDate, EndDate);
        IncomeRecord.CalcSums(Amount);
        exit(IncomeRecord.Amount);
    end;

    local procedure OpenIncomeList(d: Integer)
    var
        IncomeList: Page Zyn_IncomeList;
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
        IncomeRecord.Reset();
        IncomeRecord.SetRange("Category", Rec.Name);
        IncomeRecord.SetRange(Date, StartDate, EndDate);
        IncomeList.SetTableView(IncomeRecord);
        IncomeList.Run();
    end;
}