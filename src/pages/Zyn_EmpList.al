page 50374 "Employee List page"
{
    Caption = 'Employee List';
    PageType = List;
    SourceTable = "Employ Table";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "Employee Card page";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."Emp Id.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }

                field(role; Rec.role)
                {
                    ApplicationArea = All;
                }
            }

        }
        area(FactBoxes)
        {
            part(AssignedAssets; "Assigned Assets Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "Emp Id." = field("Emp Id.");
            }

        }
    }
}