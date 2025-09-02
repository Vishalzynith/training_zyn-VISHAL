tableextension 50138 "Text Line Ext" extends "Extended Text Line"
{
    fields
    {
        field(50101; "Bold"; Boolean)
        {
            Caption = 'Bold';
            DataClassification = CustomerContent;
        }
        field(50102; "Italic"; Boolean)
        {
            Caption = 'Italic';
            DataClassification = CustomerContent;
        }
        field(50103; "Underline"; Boolean)
        {
            Caption = 'Underline';
            DataClassification = CustomerContent;
        }
    }
}