page 50165 IndexListPart
{
    PageType = Listpart;
    ApplicationArea = All;
    SourceTable = IndexCalc;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(year; Rec.Year) { ApplicationArea = All; }
                field(Value; Rec.Value) { ApplicationArea = All; }
            }
        }

    }
}