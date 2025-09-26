page 50148 Zyn_CreditListPart
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Zyn_SubpageExtension;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Language code"; Rec."Language code")
                {
                    Caption = 'Language Code';
                }
                field("Description"; Rec."Description")
                {
                    Caption = 'Description';
                }
                field("Text"; Rec."Text")
                {
                    Caption = 'Text';
                }
                field("Document type"; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field("Bold"; Rec."Bold")
                {
                    Caption = 'Bold';
                }
                field("Italics"; Rec."Italics")
                {
                    Caption = 'Italics';
                }
                field("Underline"; Rec.Underlined)
                {
                    Caption = 'Underline';
                }
            }
        }
    }

}