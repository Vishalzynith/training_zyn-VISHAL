report 50190 Zyn_BudgetvsExpense
{
    Caption = 'Budget vs Expense Report';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem(Dummy; Integer)
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            trigger OnAfterGetRecord()
            var
                BudgetRec: Record Zyn_Budget;
                ExpenseRec: Record Zyn_Expense;
                IncomeRec: Record Zyn_Income;
                CategoryRec: Record Zyn_ExpenseCategory;
                MonthLoop: Integer;
                StartDate: Date;
                EndDate: Date;
                TotalBudget: Decimal;
                SpentBudget: Decimal;
                TotalIncome: Decimal;
                Savings: Decimal;
                MonthPrinted: Boolean;
                CategorySpent: Decimal;
            begin
                for MonthLoop := 1 to 12 do begin
                    StartDate := DMY2Date(1, MonthLoop, YearFilter);
                    EndDate := CalcDate('<CM>-1D', StartDate);
                    MonthPrinted := false;

                    TotalIncome := 0;
                    SpentBudget := 0;

                    CategoryRec.Reset();
                    if CategoryRec.FindSet() then
                        repeat
                            TotalBudget := 0;
                            CategorySpent := 0;

                            BudgetRec.Reset();
                            BudgetRec.SetRange(Category, CategoryRec.Name);
                            BudgetRec.SetFilter(FromDate, '<=%1', EndDate);
                            BudgetRec.SetFilter(ToDate, '>=%1', StartDate);
                            if BudgetRec.FindFirst() then
                                TotalBudget := BudgetRec.Amount;

                            ExpenseRec.Reset();
                            ExpenseRec.SetRange(Category, CategoryRec.Name);
                            ExpenseRec.SetRange(Date, StartDate, EndDate);
                            if ExpenseRec.FindSet() then
                                repeat
                                    CategorySpent += ExpenseRec.Amount;
                                until ExpenseRec.Next() = 0;

                            SpentBudget += CategorySpent;

                            ExcelBuf.NewRow();
                            if not MonthPrinted then begin
                                ExcelBuf.AddColumn(Format(StartDate, 0, '<Month Text>'), false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                                MonthPrinted := true;
                            end else
                                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

                            ExcelBuf.AddColumn(CategoryRec.Name, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn(TotalBudget, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
                            ExcelBuf.AddColumn(CategorySpent, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);

                        until CategoryRec.Next() = 0;

                    IncomeRec.Reset();
                    IncomeRec.SetRange(Date, StartDate, EndDate);
                    if IncomeRec.FindSet() then
                        repeat
                            TotalIncome += IncomeRec.Amount;
                        until IncomeRec.Next() = 0;

                    Savings := TotalIncome - SpentBudget;

                    ExcelBuf.NewRow();
                    ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Income', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(TotalIncome, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);

                    ExcelBuf.NewRow();
                    ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Savings', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(Savings, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.NewRow();
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(FilterGroup)
                {
                    field(YearFilter; YearFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Year';
                    }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        Clear(ExcelBuf);
        ExcelBuf.DeleteAll();
        ExcelBuf.AddColumn('Month', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Category', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Budget', false, '', true, false, true, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('Expense', false, '', true, false, true, '', ExcelBuf."Cell Type"::Number);
    end;

    trigger OnPostReport()
    begin
        ExcelBuf.CreateNewBook('Budget vs Expense');
        ExcelBuf.WriteSheet('Report', CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
    end;

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        YearFilter: Integer;
}
