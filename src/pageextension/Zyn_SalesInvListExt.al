pageextension 50137 Zyn_SalesInvListExt extends "Sales Invoice List"
{
    actions
    {
        addlast(Processing)
        {
            action(BulkPosting)
            {
                ApplicationArea = All;
                Caption = 'Bulk Posting';
                Image = PostBatch;
                trigger OnAction()
                var
                    BulkPostingReport: Report Zyn_BulkSalesInvoicePosting;
                begin
                    Report.RunModal(Report::Zyn_BulkSalesInvoicePosting, true, false);
                end;
            }
        }
    }
}