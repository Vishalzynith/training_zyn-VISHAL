page 50165 Zyn_IndexListPart
{
    PageType = Listpart;
    ApplicationArea = All;
    SourceTable = Zyn_IndexCalculations;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(year; Rec.Year)
                {
                }
                field(Value; Rec.Value)
                {
                }
            }
        }
    }
}