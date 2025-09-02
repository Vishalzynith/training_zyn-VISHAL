page 50277 "Leave Cat card"
{
    Caption = 'Leave Category Card';
    PageType = Card;
    SourceTable = "leave Category";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;
 
    layout
    {
        area(content)
        {
            group(Group)
            {
                field("No."; Rec."category name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec."Leave Description")
                {
                    ApplicationArea = All;
                }
               
                field("Max Leave Days"; Rec."NO.of days allowed")
                {
                    ApplicationArea = All;
            }
        }
    }
}
}