page 50279 "Leave Req List page"
{
    Caption = 'Leave Request List';
    PageType = List;
    SourceTable = "LeaveRequest";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    CardPageId =  "Leave Req Card page";
 
 
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No."; Rec."Request No.")
                {
                    ApplicationArea = All;
                }
                field("Emp Id.";Rec."Emp Id.")
                {
                    ApplicationArea = All;
                }
                field(Category;Rec.Category)
                {
                    ApplicationArea = All;
                }
               
                field("From Date";Rec."From Date")
                {
                    ApplicationArea = All;
                }
               
                field("To Date";Rec."To Date")
                {
                    ApplicationArea = All;
                }
               
                field("No.of days";Rec."No.of days")
                {
                    ApplicationArea = All;
                }
               
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
            }
        }
    }
}
}