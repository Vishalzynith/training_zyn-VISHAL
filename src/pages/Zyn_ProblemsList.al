page 50121 "Problem List"
{
    PageType = List;
    SourceTable = Problems;
    ApplicationArea = All;
    InsertAllowed = true;
    Editable = true;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Problem "; Rec.Problem)
                {
                    ApplicationArea = All;
                }
                field("Department"; Rec.Dept)
                {
                    ApplicationArea = All;
                }
                field("Technician"; Rec.Technician)
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
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
}
