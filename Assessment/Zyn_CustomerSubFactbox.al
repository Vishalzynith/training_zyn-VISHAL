page 50150 Zyn_CustomerSubsFactBox
{
    PageType = ListPart;
    SourceTable = Zyn_Subscription;
    Caption = 'Customer Subscriptions';
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(SubID; Rec.SubID)
                {
                    ApplicationArea = All;
                }
                field(StartDate; Rec.StartDate)
                {
                    ApplicationArea = All;
                }
                field(EndDate; Rec.EndDate)
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
