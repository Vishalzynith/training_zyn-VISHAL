page 50142 "Cust Customer List"
{
    PageType = List;
    SourceTable = Customer;
    ApplicationArea = All;
    InsertAllowed = false;
    Editable = false;
    Caption = 'Cust Customer List';
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            group(mainGroup)

            {
                repeater(Group)
                {
                    field("No."; Rec."No.")
                    {
                        ApplicationArea = All;
                    }
                    field(Name; Rec.Name)
                    {
                        ApplicationArea = All;
                    }
                    field("Address"; Rec."Address")
                    {
                        ApplicationArea = All;
                    }
                    field("City"; Rec."City")
                    {
                        ApplicationArea = All;
                    }
                    field("Phone No"; Rec."Phone No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group(SalesGroup)
            {
                Caption = 'Sales Information';

                part("Linking Sales Order"; "Linking List Part")
                {
                    ApplicationArea = All;
                    Caption = 'Linking List Part';
                    SubPageLink = "Sell-to Customer No." = field("No.");
                    SubPageView = where("Document Type" = const(Order));
                }
            }
            group(LinkingGroup)
            {
                part("Linking Sales Invoice"; "Linking List Part")
                {
                    ApplicationArea = All;
                    Caption = 'Linking Sales Invoice';
                    SubPageLink = "Sell-to Customer No." = field("No.");
                    SubPageView = where("Document Type" = const(Invoice));
                }
            }
            group(LinkingCreditMemoGroup)
            {
                part("Linking Sales Credit Memo"; "Linking List Part")
                {
                    ApplicationArea = All;
                    Caption = 'Linking Sales Credit Memo';
                    SubPageLink = "Sell-to Customer No." = field("No.");
                    SubPageView = where("Document Type" = const("Credit Memo"));
                }
            }

        }
    }
}
