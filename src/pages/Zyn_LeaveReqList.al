page 50279 Zyn_LeaveRequestList
{
    Caption = 'Leave Request List';
    PageType = List;
    SourceTable = Zyn_LeaveRequest;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    CardPageId = Zyn_LeaveRequestCard;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No."; Rec."Request No.")
                {
                }
                field("Emp Id."; Rec."Emp Id.")
                {
                }
                field(Category; Rec.Category)
                {
                }
                field("From Date"; Rec."From Date")
                {
                }
                field("To Date"; Rec."To Date")
                {
                }
                field("No.of days"; Rec."No.of days")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }
}