page 50177 Zyn_IncomeCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Zyn_Income;
    layout
    {
        area(Content)
        {
            group(IncomeCard)
            {
                field(IncomeID; Rec.IncomeID)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Category"; Rec.Category)
                {
                }
                field(Date; Rec.Date)
                {
                }
            }
        }
    }
}
