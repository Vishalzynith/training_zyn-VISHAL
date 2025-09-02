page 50108 "Modify Log List"
{
    PageType = List;
    SourceTable = "Modify Log";
    ApplicationArea = All;
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
                    ApplicationArea = All;
                }
 
                field("Customer Number"; Rec."Customer No")
                {
                    ApplicationArea = All;
                }
 
                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = All;
                }
                field("Old Value"; Rec."Prev Value")
                {
                    ApplicationArea = All;
                }
                field("New Value"; Rec."Updated Value")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."Modified By")
                {
                    ApplicationArea = All;
                }
 
            }
        }
    }
}
 
