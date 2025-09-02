pageextension 50137 SalesInvListExt extends "Sales Invoice List"
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
                    BulkPostingReport: Report "Bulk Sales Inv Posting";
                begin
                    Report.RunModal(Report::"Bulk Sales Inv Posting", true, false);
                end;
            }
        }
    }
}