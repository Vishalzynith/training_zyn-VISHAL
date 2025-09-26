pageextension 50130 Zyn_PostedInvoiceExt extends "Posted Sales Invoice"
{
    layout
    {
        addlast(Content)
        {
            part("Beginning Text Details"; Zyn_BeginListPart)
            {
                ApplicationArea = All;
                SubPageLink =
                              "No." = field("No."),
                              selection = const(Zyn_BeginEndEnum::"Begin");
                Editable = false;
            }
            part("Ending Text Details"; Zyn_EndingTextListPart)
            {
                ApplicationArea = All;
                SubPageLink =
                            "No." = field("No."),
                            selection = const(Zyn_BeginEndEnum::"End");
                Editable = false;
            }
        }
    }
}