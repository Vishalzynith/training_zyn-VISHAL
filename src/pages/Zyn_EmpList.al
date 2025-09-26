page 50374 Zyn_EmployeeList
{
    Caption = 'Employee List';
    PageType = List;
    SourceTable = Zyn_Employee;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    CardPageId = Zyn_EmployeeCard;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."Emp Id.")
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
        area(FactBoxes)
        {
            part(AssignedAssets; Zyn_AssignedAssetsFactbox)
            {
                SubPageLink = "Emp Id." = field("Emp Id.");
            }
        }
    }
}