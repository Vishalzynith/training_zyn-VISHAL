page 50123 Zyn_ProblemListPart
{
    PageType = ListPart;
    SourceTable = Zyn_Problems;
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
                }
                field("Customer Name"; CustomerName)
                {
                }
                field("Problem Description"; Rec.Problem)
                {
                }
                field("Date"; Rec.Date)
                {
                }
            }
        }
    }
    var
        CustomerRecord: Record Customer;
        CustomerNo: Code[20];
        CustomerName: Text[100];
    trigger OnAfterGetRecord()
    begin
        CustomerNo := Rec."Customer No.";
        if CustomerRecord.Get(CustomerNo) then
            CustomerName := CustomerRecord.Name
        else
            CustomerName := '';
    end;
}