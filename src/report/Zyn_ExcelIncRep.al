report 50175 Zyn_IncomeFilterPage
{
    Caption = 'Income Export Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
 
    dataset
    {
        dataitem(Income; Zyn_Income)
        {
 
            trigger OnPreDataItem()
            begin
                if (FromDate <> 0D) and (ToDate <> 0D) then
                    SetRange("Date", FromDate, ToDate)
                else if (FromDate <> 0D) then
                    SetRange("Date", FromDate, DMY2Date(31, 12, 9999))
                else if (ToDate <> 0D) then
                    SetRange("Date", 0D, ToDate);
                if CategoryFilter <> '' then
                    SetRange(Category, CategoryFilter);
            end;
 
            trigger OnAfterGetRecord()
 
            begin
                
                ExcelBuf.NewRow();
                ExcelBuf.AddColumn("IncomeID", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Description, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Format(Amount), FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(Format(Date), FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
                ExcelBuf.AddColumn(Category, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                TotalAmount += Amount;
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
                    field("From Date"; FromDate)
                    {
                        ApplicationArea = All;
                    }
                    field("To Date"; ToDate)
                    {
                        ApplicationArea = All;
                    }
                    field("Category"; CategoryFilter)
                    {
                        ApplicationArea = All;
                        TableRelation = Zyn_IncomeCategory.Name;
                    }
                }
            }
        }
    }
 
    var
        ExcelBuf: Record "Excel Buffer" temporary;
        FromDate: Date;
        ToDate: Date;
        CategoryFilter: Code[50];
        TotalAmount: Decimal;
 
    trigger OnPreReport()
    begin
        
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Income ID', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Description', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Amount', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Date', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Category', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
    end;
 
    trigger OnPostReport()
    begin
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('TOTAL', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TotalAmount, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
 
        ExcelBuf.CreateNewBook('Income Export');
        ExcelBuf.WriteSheet('Income', CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
    end;
}
 
 