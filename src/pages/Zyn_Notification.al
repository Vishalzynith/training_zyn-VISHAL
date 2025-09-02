page 50197 "My Notification Part"
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
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage();
    var
        NotificationMgt: Codeunit "My Notification Mgt.";
    begin
        NotificationMgt.ShowNoti();
    end;
}