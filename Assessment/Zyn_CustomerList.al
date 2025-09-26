//Assessment Lines 19-23
pageextension 50122 Zyn_CustomerList extends "Customer List"
{
    layout
    {
        addlast(factboxes)
        {
            part(OpenDocsFactBox; Zyn_CustomerOpenDocsFactBox)
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = All;
            }
            part(ContactFactBox; Zyn_CustomerContactFactBox)
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = All;
            }
            part(CustomerSubscriptions; Zyn_CustomerSubsFactBox)
            {
                ApplicationArea = All;
                SubPageLink = CustomerID = FIELD("No.");
            }
        }
    }
}
