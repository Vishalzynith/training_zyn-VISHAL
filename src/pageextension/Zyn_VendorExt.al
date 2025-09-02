pageextension 50115 VendorListExt extends "Vendor List"
{
    layout
    {
        addafter("Name")
        {
            field("Notes123"; Rec."Notes123")
            {
                ApplicationArea = All;

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
