page 50101 "Field Lookup Buffer Page"
{
    PageType = List;
    SourceTable = "Field Lookup Buffer";
    SourceTableTemporary = true;
    ApplicationArea = All;
    UsageCategory = None;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("FieldName"; Rec."Field Name")
                {
                    ApplicationArea = All;
                    Caption = 'Field Name';
                }
            }
        }
    }
}