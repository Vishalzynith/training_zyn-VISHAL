page 50172 BudgetCatStatsFactbox
{
    PageType = CardPart;
    SourceTable = "ExpenseCat";
    ApplicationArea = All;
    Caption = 'Category Budget Summary';
    layout
    {
        area(content)
        {
            cuegroup(Summary)
            {
                field(CurrentMonth; CurrMonthBudget)
                {
                    ApplicationArea = All;
                    Caption = 'Monthly Budget';
                    trigger OnDrillDown()
                    begin
                        OpenBudgetList(1);
                    end;
                }
                field(CurrentQuarter; CurrQuarterBudget)
                {
                    ApplicationArea = All;
                    Caption = 'Quarterly Budget';
                    trigger OnDrillDown()
                    begin
                        OpenBudgetList(2);
                    end;
                }
                field(CurrentHalfYear; CurrHalfYearBudget)
                {
                    ApplicationArea = All;
                    Caption = 'Half-Yearly Budget';
                    trigger OnDrillDown()
                    begin
                        OpenBudgetList(3);
                    end;
                }
                field(CurrentYear; CurrYearBudget)
                {
                    ApplicationArea = All;
                    Caption = 'Yearly Budget';
                    trigger OnDrillDown()
                    begin
                        OpenBudgetList(4);
                    end;
                }
                field(PrevYear; PrevYearBudget)
                {
                    ApplicationArea = All;
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
        BudgetRec: Record Budget;
        CurrMonthBudget: Decimal;
        CurrQuarterBudget: Decimal;
        CurrHalfYearBudget: Decimal;
        CurrYearBudget: Decimal;
        PrevYearBudget: Decimal;

    trigger OnAfterGetRecord()
    var
        StartDate: Date;
        EndDate: Date;
        CurrMonth: Integer;
        CurrQuarter: Integer;
        CurrYear: Integer;
        PrevYear: Integer;
        WorkDt: Date;
    begin
        Clear(CurrMonthBudget);
        Clear(CurrQuarterBudget);
        Clear(CurrHalfYearBudget);
        Clear(CurrYearBudget);
        Clear(PrevYearBudget);

        WorkDt := WorkDate();
        CurrYear := Date2DMY(WorkDt, 3);
        CurrMonth := Date2DMY(WorkDt, 2);
        CurrQuarter := (CurrMonth - 1) div 3 + 1;
        PrevYear := CurrYear - 1;

        StartDate := DMY2Date(1, CurrMonth, CurrYear);
        EndDate := CalcDate('<CM>', StartDate);
        CurrMonthBudget := GetBudgetTotal(Rec.Name, StartDate, EndDate);


        StartDate := DMY2Date(1, (CurrQuarter - 1) * 3 + 1, CurrYear);
        EndDate := CalcDate('<CQ>', StartDate);
        CurrQuarterBudget := GetBudgetTotal(Rec.Name, StartDate, EndDate);

        
        if CurrMonth <= 6 then begin
            StartDate := DMY2Date(1, 1, CurrYear);
            EndDate := DMY2Date(30, 6, CurrYear);
        end else begin
            StartDate := DMY2Date(1, 7, CurrYear);
            EndDate := DMY2Date(31, 12, CurrYear);
        end;
        CurrHalfYearBudget := GetBudgetTotal(Rec.Name, StartDate, EndDate);

        
        StartDate := DMY2Date(1, 1, CurrYear);
        EndDate := DMY2Date(31, 12, CurrYear);
        CurrYearBudget := GetBudgetTotal(Rec.Name, StartDate, EndDate);

        
        StartDate := DMY2Date(1, 1, PrevYear);
        EndDate := DMY2Date(31, 12, PrevYear);
        PrevYearBudget := GetBudgetTotal(Rec.Name, StartDate, EndDate);
    end;

    local procedure GetBudgetTotal(CategoryName: Code[20]; StartDate: Date; EndDate: Date): Decimal
    var
        TempBudget: Record Budget;
    begin
        TempBudget.Reset();
        TempBudget.SetRange(Category, CategoryName);
        TempBudget.SetFilter(FromDate, '<=%1', EndDate);
        TempBudget.SetFilter(ToDate, '>=%1', StartDate);
        TempBudget.CalcSums(Amount);
        exit(TempBudget.Amount);
    end;

    local procedure OpenBudgetList(d: Integer)
    var
        BudgetList: Page "BudgetList"; 
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

        BudgetRec.Reset();
        BudgetRec.SetRange("Category", Rec.Name);
        BudgetRec.SetFilter(FromDate, '<=%1', EndDate);
        BudgetRec.SetFilter(ToDate, '>=%1', StartDate);

        BudgetList.SetTableView(BudgetRec);
        BudgetList.Run();
    end;
}
