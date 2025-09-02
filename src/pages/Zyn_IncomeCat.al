page 50178 IncomeCat
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = IncomeCat;
    Editable=false;
    InsertAllowed = false;
    ModifyAllowed = false;
    CardPageId = 50179;
    layout
    {
        area(Content)
        {
            repeater(IncomeList){
            field(CategoryNo; Rec.CategoryNo) { ApplicationArea = All; }
            field(Name; Rec.Name) { ApplicationArea = All; }
            field(Description; Rec.Description) { ApplicationArea = All; }
        }}
        area(FactBoxes)
        {
            part(IncomeCatStatsFactbox; IncomeCatStatsFactbox)
            {
                ApplicationArea = All;
                SubPageLink=Name=field(Name);
            }
        }

    }
}