page 50143 Zyn_SalesHeaderListPart
{
    PageType = ListPart;
    SourceTable = "Sales Header";
    ApplicationArea = All;
    InsertAllowed = false;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    trigger OnDrillDown()
                    begin
                        case Rec."Document Type" of
                            Rec."Document Type"::Order:
                                PAGE.Run(PAGE::"Sales Order", Rec);
                            Rec."Document Type"::Invoice:
                                PAGE.Run(PAGE::"Sales Invoice", Rec);
                            Rec."Document Type"::"Credit Memo":
                                PAGE.Run(PAGE::"Sales Credit Memo", Rec);
                        end;
                    end;
                }
                field("Sell to Customer No"; Rec."Sell-to Customer No.")
                {
                }
                field("Sell to Customer Name"; Rec."Sell-to Customer Name")
                {
                }
            }
        }
    }
}
