page 50142 Zyn_CustomCustomerList
{
    PageType = List;
    SourceTable = Customer;
    ApplicationArea = All;
    InsertAllowed = false;
    Editable = false;
    Caption = 'Custom Customer List';
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
                        Caption='Customer No.';
                    }
                    field(Name; Rec.Name)
                    {
                       Caption='Name';
                    }
                    field("Address"; Rec."Address")
                    {
                       Caption='Address';
                    }
                    field("City"; Rec."City")
                    {
                      Caption='City';
                    }
                    field("Phone No"; Rec."Phone No.")
                    {
                       Caption='Phone No';
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                       Caption='Post Code';
                    }
                }
            }
            group(SalesGroup)
            {
                Caption = 'Sales Information';
                part("Linking Sales Order"; Zyn_SalesHeaderListPart)
                {
                    ApplicationArea = All;
                    Caption = 'Linking List Part';
                    SubPageLink = "Sell-to Customer No." = field("No.");
                    SubPageView = where("Document Type" = const(Order));
                }
            }
            group(LinkingGroup)
            {
                part("Linking Sales Invoice"; Zyn_SalesHeaderListPart)
                {
                    ApplicationArea = All;
                    Caption = 'Linking Sales Invoice';
                    SubPageLink = "Sell-to Customer No." = field("No.");
                    SubPageView = where("Document Type" = const(Invoice));
                }
            }
            group(LinkingCreditMemoGroup)
            {
                part("Linking Sales Credit Memo"; Zyn_SalesHeaderListPart)
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
