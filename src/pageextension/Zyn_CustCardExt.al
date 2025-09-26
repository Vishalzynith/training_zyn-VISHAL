
pageextension 50111 Zyn_CustomerCardExt extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Credits Allowed"; Rec."Credits Allowed")
            {
                Caption = 'Credits Allowed';
            }
            field("Credits Used"; Rec."Credits Used")
            {
                Caption = 'Credits Used';
                Editable = false;
            }
            field("Sales Year"; Rec."Sales Year")
            {
                Caption = 'Sales Year';
            }
            field("Loyalty Points Used"; Rec."Loyalty Points Used")
            {
                Caption = 'Loyalty Points Used';
                Editable = false;
            }
            field("Loyalty Points Allowed"; Rec."Loyalty Points Allowed")
            {
                Caption = 'Loyalty Points Allowed';
            }

        }
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
                RunObject = page Zyn_ModifyLogList;
                RunPageLink = "Customer No" = field("No.");
            }
            action(Problems)
            {
                ApplicationArea = All;
                Caption = 'Problems & Queries';
                Image = Questionaire;
                RunObject = page Zyn_ProblemList;
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
        Publisher: Codeunit Zyn_CompanyChangePublisher;
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


