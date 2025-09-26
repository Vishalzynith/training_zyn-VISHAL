report 50121 Zyn_BulkSalesInvoicePosting
{
    Caption = 'Bulk Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = where("Document Type" = const(Invoice));
            trigger OnAfterGetRecord()
            var
                SalesPost: Codeunit "Sales-Post";
            begin
                SalesPost.Run("Sales Header");
                PostedCount += 1;
            end;
        }
    }
    trigger OnPostReport()
    begin
        Message('%1 sales invoice has been posted successfully! Task Completed(Zyn_06/08/2025)', PostedCount);
    end;

    var
        PostedCount: Integer;
}
