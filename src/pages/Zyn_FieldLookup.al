page 50101 Zyn_FieldLookupBufferPage
{
    PageType = List;
    SourceTable = Zyn_FieldLookupBuffer;
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
                    Caption = 'Field Name';
                }
            }
        }
    }
}