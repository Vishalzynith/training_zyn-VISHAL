page 50190 BudgetListPart
{
    PageType = Listpart;
    ApplicationArea = All;
    SourceTable = Budget;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(BudgetList)
            {
                field(BudgetID; Rec.BudgetID) { ApplicationArea = All; }
                field(Category; Rec.Category) { ApplicationArea = All; }
                field(Amount; Rec.Amount) { ApplicationArea = All; }
                field(FromDate; Rec.FromDate) { ApplicationArea = All; }
                field(ToDate; Rec.ToDate) { ApplicationArea = All; }
            }
        }
        
    }

}