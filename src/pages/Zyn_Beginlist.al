page 50207 BeginListPart
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Subpageext;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Language code"; Rec."Language code")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
                field("Text"; Rec."Text")
                {
                    ApplicationArea = All;
                }
                field("Document type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Bold"; Rec."Bold")
                {
                    ApplicationArea = All;
                }
                field("Italics"; Rec."Italics")
                {
                    ApplicationArea = All;
                }
                field("Underline"; Rec.Underlined)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}