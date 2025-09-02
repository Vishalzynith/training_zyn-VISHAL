
pageextension 50111 CustomerCard1Ext extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Credits Allowed"; Rec."Credits Allowed")
            {
                ApplicationArea = All;
            }
            field("Credits Used"; Rec."Credits Used")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Sales Year"; Rec."Sales Year")
            {
                ApplicationArea = All;
            }
            field("Loyalty Points Used"; Rec."Loyalty Points Used")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Loyalty Points Allowed"; Rec."Loyalty Points Allowed")
            {
                ApplicationArea = All;
            }

        }
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
    actions
    {
        addlast(processing)
        {
            action(ModifyLog)
            {
                ApplicationArea = All;
                Caption = 'Modify Log';
                Image = Edit;
                RunObject = page "Modify Log List";
                RunPageLink = "Customer No" = field("No.");
            }
            action(Problems)
            {
                ApplicationArea = All;
                Caption = 'Problems & Queries';
                Image = Questionaire;
                RunObject = page "Problem List";
                RunPageLink = "Customer No." = field("No.");
            }
        }

    }
    var
        IsNewCustomer: Boolean;

    trigger OnOpenPage()
    begin
        if Rec."No." = '' then
            IsNewCustomer := true;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if IsNewCustomer and (Rec.Name = '') then begin
            Message('Please enter a customer name before closing the page.');
            exit(false); 
        end;

        exit(true); 
    end;

    trigger OnClosePage()
    var
        Publisher: Codeunit compchangepublisher;
    begin
        if IsNewCustomer and (Rec.Name <> '') then
            Publisher.OnaddCustomerCreated(Rec);
    end;
}
pageextension 50112 PurchaseOrderExt extends "Purchase Order"
{
    layout
    {
        addlast(General)
        {
            field("Approval Status"; Rec."Approval Status")
            {
                ApplicationArea = All;
            }
        }
    }

}


