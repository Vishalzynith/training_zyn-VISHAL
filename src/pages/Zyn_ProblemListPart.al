page 50123 "Problem List Part"
{
    PageType = ListPart;
    SourceTable = Problems;
    ApplicationArea = All;
    InsertAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; CustomerName)
                {
                    ApplicationArea = All;
                }
                field("Problem Description"; Rec.Problem)
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec.Date)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        CustomerRec: Record Customer;
        CustomerNo: Code[20];
        CustomerName: Text[100];

    trigger OnAfterGetRecord()
    begin
        CustomerNo := Rec."Customer No.";
        if CustomerRec.Get(CustomerNo) then
            CustomerName := CustomerRec.Name
        else
            CustomerName := '';
    end;
}