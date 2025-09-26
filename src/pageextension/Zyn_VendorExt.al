pageextension 50115 Zyn_VendorListExt extends "Vendor List"
{
    layout
    {
        addafter("Name")
        {
            field("Notes123"; Rec."Notes123")
            {
                ApplicationArea = All;
                Caption = 'Notes123';

            }

        }

    }
}
pageextension 50110 VendorCardExt extends "Vendor Card"
{
    layout
    {
        addafter("Name")
        {
            field(Notes123; Rec.Notes123)
            {
                ApplicationArea = All;

            }

        }

    }
}
