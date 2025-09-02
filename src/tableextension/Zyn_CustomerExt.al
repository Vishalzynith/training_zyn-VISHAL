
tableextension 50115 CustomerExt extends Customer
{
    fields
    {
        field(50106; "Credits Allowed"; Decimal)
        {
            Caption = 'Credits Allowed';
            DataClassification = CustomerContent;
        }
        field(50101; "Credits Used"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Amount"
                WHERE("Sell-to Customer No." = FIELD("No.")));
            Caption = 'Credits Used';
            Editable = false;
        }
        field(50102; "Sales Year"; Date)
        {
            Caption = 'Sales Year';
            FieldClass = FlowFilter;
        }
        field(50104; "Loyalty Points Used"; Decimal)
        {
            Caption = 'Loyalty Points';
            Editable = false;
        }
        field(50105; "Loyalty Points Allowed"; Decimal)
        {
            Caption = 'Loyalty Points Allowed';
            DataClassification = CustomerContent;
        }
    }
}
tableextension 50119 SalesLineExt extends "Sales Line"
{
    trigger OnInsert()
    begin
        CheckCustomerCreditLimit();
    end;

    trigger OnModify()
    begin
        CheckCustomerCreditLimit();
    end;

    local procedure CheckCustomerCreditLimit()
    var
        CustomerRec: Record Customer;
    begin
        if "Sell-to Customer No." = '' then
            exit;
        if CustomerRec.Get("Sell-to Customer No.") then begin
            CustomerRec.CalcFields("Credits Used");
            if (CustomerRec."Credits Used" + "Amount") > CustomerRec."Credits Allowed" then
                Error(
                    'Credit limit exceeded for customer %1. Used: %2, Allowed: %3',
                    CustomerRec."No.", CustomerRec."Credits Used" + "Amount", CustomerRec."Credits Allowed");
        end;
    end;
}

tableextension 50120 PruchaseApprovalExt extends "Purchase Header"
{
    fields
    {
        field(50104; "Approval Status"; Enum Microsoft.Purchases.Document."Approval Status")
        {
            Caption = 'Approval Status';
            DataClassification = CustomerContent;
        }
    }
}