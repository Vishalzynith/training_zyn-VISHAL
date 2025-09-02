pageextension 50130 "PostedInvoiceExt" extends "Posted Sales Invoice"
{
    layout
    {
        addlast(Content)
        {
            part("Beginning Text Details"; BeginListPart)
            {
                ApplicationArea = All;
                SubPageLink = 
                              "No." = field("No."),
                              selection = const(BeginEndEnum::"Begin");
                Editable = false;
            }
            part("Ending Text Details"; EndListPart)
            {
                ApplicationArea = All;
                SubPageLink = 
                            "No." = field("No."),
                            selection = const(BeginEndEnum::"End");
                Editable = false;
            }
        }
    }
}