page 50135 Zyn_TechnicianList
{
    PageType = List;
    SourceTable = Zyn_Technician;
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
                }
                field("Name"; Rec.Name)
                {
                }
                field("Phone No"; Rec."Phone No.")
                {
                }
                field("Dept"; Rec.Dept)
                {
                }
                field("Problem Count"; Rec."Problem Count")
                {
                }
            }
            part(ProblemList; Zyn_ProblemListPart)
            {
                ApplicationArea = All;
                SubPageLink = Technician = field(ID);
            }
        }
    }
}
