pageextension 50109 ContactListExt extends "Contact List"
{
    actions
    {
        addlast(Processing)
        {
            action(FilterCustomers)
            {
                ApplicationArea = All;
                Caption = 'Customers';
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedOnly = false;
                trigger OnAction()
                var
                    CustomerEnum: Enum "Contact Business Relation";
                begin
                    CustomerEnum := CustomerEnum::Customer;
                    Rec.SetRange("Contact Business Relation", CustomerEnum);
                    CurrPage.Update(false);
                end;
            }
            action(FilterVendors)
            {
                ApplicationArea = All;
                Caption = 'Vendors';
                Image = Vendor;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedOnly = false;
                trigger OnAction()
                var
                    ContactRelationEnum: Enum "Contact Business Relation";
                begin
                    ContactRelationEnum := ContactRelationEnum::Vendor;
                    Rec.SetRange("Contact Business Relation", ContactRelationEnum);
                    CurrPage.Update(false);
                end;
            }
            action(FilterBankAccounts)
            {
                ApplicationArea = All;
                Caption = 'Bank Accounts';
                Image = Bank;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedOnly = false;
                trigger OnAction()
                var
                    ContactRelationEnum: Enum "Contact Business Relation";
                begin
                    ContactRelationEnum := ContactRelationEnum::"Bank Account";
                    Rec.SetRange("Contact Business Relation", ContactRelationEnum);
                    CurrPage.Update(false);
                end;
            }
            action(ClearFilters)
            {
                ApplicationArea = All;
                Caption = 'Clear Filters';
                Image = ClearFilter;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedOnly = false;
                trigger OnAction()
                begin
                    Rec.Reset();
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
