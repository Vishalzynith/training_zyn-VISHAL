pageextension 50136 "Zyn_CreditPostedInvoiceExt" extends "Posted Sales Credit Memo"
{
    layout
    {
        addlast(Content)
        {
            part("Credit Begin Text Part"; Zyn_CreditListPart)
            {
                ApplicationArea = All;
                SubPageLink =
                              "No." = field("No."),
                              selection = const(BeginEndEnum::"Begin");
                Editable = false;
            }
            part("Credit End Text Part"; Zyn_EndListPart)
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