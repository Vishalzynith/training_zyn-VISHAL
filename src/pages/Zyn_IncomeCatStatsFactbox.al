page 50181 IncomeCatStatsFactbox
{
    PageType = CardPart;
    SourceTable = "IncomeCat";
    ApplicationArea = All;
    Caption = 'Category Income Summary';
    layout
    {
        area(content)
        {
            cuegroup(Summary)
            {
                field(CurrentMonth; CurrMonthIncome)
                {
                    ApplicationArea = All;
                    Caption = 'Current Month';
                    trigger OnDrillDown()
                    begin
                        OpenIncomeList(1);
                    end;
                }
                field(CurrentQuarter; CurrQuarterIncome)
                {
                    ApplicationArea = All;
                    Caption = 'Current Quarter';
                    trigger OnDrillDown()
                    begin
                        OpenIncomeList(2);
                    end;
                }
                field(CurrentHalfYear; CurrHalfYearIncome)
                {
                    ApplicationArea = All;
                    Caption = 'Current Half-Year';
                    trigger OnDrillDown()
                    begin
                        OpenIncomeList(3);
                    end;
                }
                field(CurrentYear; CurrYearIncome)
                {
                    ApplicationArea = All;
                    Caption = 'Current Year';
                    trigger OnDrillDown()
                    begin
                        OpenIncomeList(4);
                    end;
                }
                field(PrevYear; PrevYearIncome)
                {
                    ApplicationArea = All;
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
        IncomeRec: Record "Income";
        CurrMonthIncome: Decimal;
        CurrQuarterIncome: Decimal;
        CurrHalfYearIncome: Decimal;
        CurrYearIncome: Decimal;
        PrevYearIncome: Decimal;

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
        Clear(CurrMonthIncome);
        Clear(CurrQuarterIncome);
        Clear(CurrHalfYearIncome);
        Clear(CurrYearIncome);
        Clear(PrevYearIncome);
        WorkDt := WorkDate();
        CurrYear := Date2DMY(WorkDt, 3);
        CurrMonth := Date2DMY(WorkDt, 2);
        CurrQuarter := (CurrMonth - 1) div 3 + 1;
        PrevYear := CurrYear - 1;

        StartDate := DMY2Date(1, 1, PrevYear);
        EndDate := DMY2Date(31, 12, PrevYear);
        PrevYearIncome := GetIncomeTotal(Rec.Name, StartDate, EndDate);

        StartDate := DMY2Date(1, CurrMonth, CurrYear);
        EndDate := CalcDate('<CM>', StartDate);
        CurrMonthIncome := GetIncomeTotal(Rec.Name, StartDate, EndDate);

        StartDate := DMY2Date(1, (CurrQuarter - 1) * 3 + 1, CurrYear);
        EndDate := CalcDate('<CQ>', StartDate);
        CurrQuarterIncome := GetIncomeTotal(Rec.Name, StartDate, EndDate);
        if CurrMonth <= 6 then
            StartDate := DMY2Date(1, 1, CurrYear)
        else
            StartDate := DMY2Date(1, 7, CurrYear);

        if CurrMonth <= 6 then
            EndDate := DMY2Date(30, 6, CurrYear)
        else
            EndDate := DMY2Date(31, 12, CurrYear);

        CurrHalfYearIncome := GetIncomeTotal(Rec.Name, StartDate, EndDate);

        StartDate := DMY2Date(1, 1, CurrYear);
        EndDate := DMY2Date(31, 12, CurrYear);
        CurrYearIncome := GetIncomeTotal(Rec.Name, StartDate, EndDate);
    end;

    local procedure GetIncomeTotal(CategoryName: Code[20]; StartDate: Date; EndDate: Date): Decimal
    begin
        IncomeRec.Reset();
        IncomeRec.SetRange("Category", CategoryName);
        IncomeRec.SetRange(Date, StartDate, EndDate);
        IncomeRec.CalcSums(Amount);
        exit(IncomeRec.Amount);
    end;

    local procedure OpenIncomeList(d: Integer)
    var
        IncomeList: Page "IncomeList";
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
        IncomeRec.Reset();
        IncomeRec.SetRange("Category", Rec.Name);
        IncomeRec.SetRange(Date, StartDate, EndDate);
        IncomeList.SetTableView(IncomeRec);
        IncomeList.Run();
    end;
}