page 50177 IncomeCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Income;

    layout
    {
        area(Content)
        {
            group(IncomeCard)
            {
                field(IncomeID; Rec.IncomeID) { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field(Amount; Rec.Amount) { ApplicationArea = All; }
                field("Category"; Rec.Category) { ApplicationArea = All; }
                field(Date; Rec.Date) { ApplicationArea = All; }
            }
        }
    }
}
