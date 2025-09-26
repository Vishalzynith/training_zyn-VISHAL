//Lines 21,22 : Subscription Notification Task
page 50212 Zyn_SubscriptionCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Zyn_Subscription;

    layout
    {
        area(Content)
        {
            group(SubscriptionCard)
            {
                field(SubID; Rec.SubID) { ApplicationArea = All; }
                field(CustomerID; Rec.CustomerID) { ApplicationArea = All; }
                field(PlanID; Rec.PlanID) { ApplicationArea = All; }
                field(StartDate; Rec.StartDate) { ApplicationArea = All; }
                field(Duration; Rec.Duration) { ApplicationArea = All; }
                field(EndDate; Rec.EndDate) { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; }
                field(NextBilling; Rec.NextBilling) { ApplicationArea = All; }
                field("Next Renewal Date"; Rec."Next Renewal Date") { ApplicationArea = All; }
                field("Reminder Sent"; Rec."Reminder Sent") { ApplicationArea = All; }
            }
        }
    }
}
