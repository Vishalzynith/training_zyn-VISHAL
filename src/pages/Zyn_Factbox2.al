page 50160 Zyn_CustomerContactFactBox
{
    PageType = CardPart;
    SourceTable = Customer;
    ApplicationArea = All;
    Caption='';
    Editable = false;
 
    layout
    {
        area(content)
        {
            group(ContactInfoGroup)
            {
                Visible = ShowContactInfo;
                field("Contact Code"; Rec."Primary Contact No.")
                {
                   Caption='Contact Code';
                }
                field("Contact Name"; Rec.Contact)
                {
                   Caption='Contact Name';
                }
            }
        }
    }
    var
        ShowContactInfo: Boolean;
    trigger OnAfterGetRecord()
    begin
        ShowContactInfo := (Rec."Primary Contact No." <> '') and (Rec.Contact <> '');
        if ShowContactInfo then
            CurrPage.Caption:='Customer Contact Info'
        else
            CurrPage.Caption:=''
    end;
}
 
 