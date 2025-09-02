tableextension 50139 SalesHeaderExt extends "Sales Header"
{
    fields
    {
        field(50101; "Beginning Text"; Text[50])
        {
            Caption = 'Beginning Text';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text".Code;
        }
        field(50102; "Ending Text"; Text[50])
        {
            Caption = 'Ending Text';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text".Code;
        }
        field(50103; "Beginning Invoice Text"; Text[50])
        {
            Caption = 'Beginning Invoice Text';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text".Code;
        }
        field(50104; "Ending Invoice Text"; Text[50])
        {
            Caption = 'Ending Invoice Text';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text".Code;
        }

        field(50106; "Last Sold Price"; Decimal)
        {
            Caption = 'Last Sold Price';
            FieldClass = FlowField;
            CalcFormula = Max("LastSoldPrice".ItemPrice WHERE(CustomerNo = FIELD("Sell-to Customer No."), PostingDate = FIELD("Latest Posting Date")));
            Editable = false;
        }

        field(50107; "Latest Posting Date"; Date)
        {
            Caption = 'Latest Posting Date';
            FieldClass = FlowField;
            CalcFormula = Max("LastSoldPrice".PostingDate WHERE(CustomerNo = FIELD("Sell-to Customer No.")));
            Editable = false;
        }

    }
    trigger OnAfterDelete()
    var
        SubpageextRec: Record Subpageext;
    begin
        SubpageextRec.SetRange("Document Type", Rec."Document Type");
        SubpageextRec.SetRange("No.", Rec."No.");
        if not SubpageextRec.IsEmpty then
            SubpageextRec.DeleteAll();
    end;
}