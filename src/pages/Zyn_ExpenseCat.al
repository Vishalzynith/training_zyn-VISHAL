page 50168 ExpenseCat
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = ExpenseCat;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    CardPageId = 50169;
    layout
    {
        area(Content)
        {
            repeater(ExpenseList)
            {
                field(CategoryNo; Rec.CategoryNo) { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
            }
        }
        area(FactBoxes)
        {
            part(ExpenseCatStatsFactbox; ExpenseCatStatsFactbox)
            {
                ApplicationArea = All;
                SubPageLink = Name = field(Name);
            }
            part(BudgetCatStatsFactbox; BudgetCatStatsFactbox)
            {
                ApplicationArea = All;
                SubPageLink = Name = field(Name);
            }
        }

    }
}