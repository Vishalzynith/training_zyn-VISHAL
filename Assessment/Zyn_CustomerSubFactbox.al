page 50150 "Customer Subscription FactBox"
{
    PageType = ListPart;
    SourceTable = Subscription; // Your subscription table
    Caption = 'Customer Subscriptions';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(SubID;Rec.SubID)
                {
                    ApplicationArea = All;
                }
                field(StartDate;Rec.StartDate)
                {
                    ApplicationArea = All;
                }
                field(EndDate;Rec.EndDate)
                {
                    ApplicationArea = All;
                }
                field(Status;Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
