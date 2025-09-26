page 50178 Zyn_IncomeCategory
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = Zyn_IncomeCategory;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    CardPageId = 50179;
    layout
    {
        area(Content)
        {
            repeater(IncomeList)
            {
                field(CategoryNo; Rec.CategoryNo)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
        area(FactBoxes)
        {
            part(IncomeCatStatsFactbox; Zyn_IncomeCategoryFactbox)
            {
                SubPageLink = Name = field(Name);
            }
        }
    }
}