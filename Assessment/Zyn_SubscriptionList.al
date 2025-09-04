page 50211 SubscriptionList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Subscription;
    CardPageId = 50212;
    //Editable=false;
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(SubscriptionList)
            {
                field(SubID;Rec.SubID) { ApplicationArea = All; }
                field(CustomerID;Rec.CustomerID) { ApplicationArea = All; }
                field(PlanID;Rec.PlanID){ApplicationArea=All;}
                field(StartDate;Rec.StartDate){ApplicationArea=All;}
                field(Duration;Rec.Duration){ApplicationArea=All;}
                field(EndDate;Rec.EndDate){ApplicationArea=All;}
                field(Status;Rec.Status){ApplicationArea=All;}
                field(NextBilling;Rec.NextBilling){ApplicationArea=All;}
            }
        }
    }
}