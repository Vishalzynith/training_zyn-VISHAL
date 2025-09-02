page 50160 "Customer Contact FactBox"
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
                    ApplicationArea = All;
                }
                field("Contact Name"; Rec.Contact)
                {
                    ApplicationArea = All;
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
 
 