table 50158 Zyn_LastSoldPrice
{
    DataClassification = ToBeClassified;

    fields
    {
        field(2; CustomerNo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer No.';

        }
        field(3; ItemNo; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Item No.';
        }
        field(4; ItemPrice; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Item Price';
        }
        field(5; PostingDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting Date';
        }
    }

    keys
    {
        key(PK; CustomerNo, ItemNo)
        {
            Clustered = true;
        }
    }
}