pageextension 50138 ExtendedTextLine extends "Extended Text Lines"
{
    layout
    {
        addafter("Text")
        {
            field("Bold"; Rec.Bold)
            {
                ApplicationArea = All;
            }
            field("Italic"; Rec.Italic)
            {
                ApplicationArea = All;
            }
            field("Underline"; Rec.Underline)
            {
                ApplicationArea = All;
            }
        }
    }
}

