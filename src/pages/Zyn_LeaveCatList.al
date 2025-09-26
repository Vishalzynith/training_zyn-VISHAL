page 50276 Zyn_LeaveCategoryList
{
    Caption = 'Leave Category List';
    PageType = List;
    SourceTable = Zyn_LeaveCategory;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    CardPageId = Zyn_LeaveCategoryCard;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."category name")
                {
                }
                field(Description; Rec."Leave Description")
                {
                }
                field("Max Leave Days"; Rec."NO.of days allowed")
                {
                }
            }
        }
    }
}