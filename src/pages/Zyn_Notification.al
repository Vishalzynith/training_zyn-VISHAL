page 50197 Zyn_NotificationCardPart
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "User Setup";
    layout
    {
        area(content)
        {
            group(Group)
            {
                field(UserID; UserId())
                {
                }
            }
        }
    }
    trigger OnOpenPage();
    var
        NotificationManagement: Codeunit Zyn_NotificationManagement;
    begin
        NotificationManagement.ShowNoti();
    end;
}