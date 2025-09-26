report 50122 Zyn_PostingDateUpdate
{
    Caption = 'Posting Date Updation';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly=true; 
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = where("Document Type" = const(Order),
                                      Status = const(Open));
            trigger OnAfterGetRecord()
            begin
                if "Sales Header"."Posting Date" <> NewPostingDate then begin
                    "Sales Header"."Posting Date" := NewPostingDate;
                    "Sales Header".Modify(true);
                    UpdatedCount += 1;
                end;
            end;
 
        }
    } 
    requestpage
    {
        layout
        {
            area(content)
            {
                group("Options")
                {
                    field(NewPostingDate; NewPostingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'New Posting Date';
                    }
                }
            }
        }
 
        trigger OnOpenPage()
        begin
            NewPostingDate := Today;
        end;
    }
    trigger OnPostReport()
    begin
        Message('%1 open sales orders updated with new posting date: %2',
            UpdatedCount, Format(NewPostingDate));
    end; 
    var
        NewPostingDate: Date;
        UpdatedCount: Integer;
}
 
 