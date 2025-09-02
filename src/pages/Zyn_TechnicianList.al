page 50135 "Technician List"
{
    PageType = List;
    SourceTable = Technician;
    ApplicationArea = All;
    InsertAllowed = true;
    Editable = true;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("ID"; Rec.ID)
                {
                    ApplicationArea = All;
                }
                field("Name"; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Phone No"; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Dept"; Rec.Dept)
                {
                    ApplicationArea = All;
                }
                field("Problem Count"; Rec."Problem Count")
                {
                    ApplicationArea = All;
                }

            }
            part(ProblemList; "Problem List Part")
            {
                ApplicationArea = All;
                SubPageLink = Technician = field(ID);
            }
        }
    }
}
