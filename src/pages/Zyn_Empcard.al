page 50275 Zyn_EmployeeCard
{
    Caption = 'Employee Card';
    PageType = Card;
    SourceTable = Zyn_Employee;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;
 
    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Emp Id"; Rec."Emp Id.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Department; Rec.Department)
                {
                }
               
                field(role; Rec.role)
                {
                }
            }
        }
    }
}
 