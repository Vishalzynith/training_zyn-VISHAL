page 50210 Zyn_PlanCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Zyn_Plans;

    layout
    {
        area(Content)
        {
            group(PlanCard)
            {
                field(PlanID; Rec.PlanID)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Fee; Rec.Fee)
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
