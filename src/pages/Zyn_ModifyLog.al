page 50108 Zyn_ModifyLogList
{
    PageType = List;
    SourceTable = Zyn_ModifyLog;
    ApplicationArea=All;
    InsertAllowed = false;
    Editable = False;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                }
                field("Customer Number"; Rec."Customer No")
                {
                }
                field("Field Name"; Rec."Field Name")
                {
                }
                field("Old Value"; Rec."Prev Value")
                {        
                }
                field("New Value"; Rec."Updated Value")
                {                 
                }
                field("User ID"; Rec."Modified By")
                {                   
                }
            }
        }
    }
}
 
