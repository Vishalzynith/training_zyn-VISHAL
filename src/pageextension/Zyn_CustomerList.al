pageextension 50122 MyExtension extends "Customer List"
{
    
    layout
    {
        addlast(factboxes)
        {
            part(OpenDocsFactBox; "Customer Open Docs FactBox")
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = All;
            }
            part(ContactFactBox; "Customer Contact FactBox")
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = All;
            }
            
        }
        
    }
    // trigger OnOpenPage();
    // begin
    //     report.Run(Report::"Sales Invoice RDLC");
    // end;
}
