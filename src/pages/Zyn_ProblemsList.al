page 50121 Zyn_ProblemList
{
    PageType = List;
    SourceTable = Zyn_Problems;
    ApplicationArea=All;
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
                }
                field("Department"; Rec.Dept)
                {                  
                }
                field("Technician"; Rec.Technician)
                {                   
                }
                field("Description"; Rec.Description)
                {                   
                }
                field("Date"; Rec.Date)
                {         
                }
            }
        }
    }
}
