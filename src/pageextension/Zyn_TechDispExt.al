pageextension 50142 Zyn_TechnicianDispExt extends "Business Manager Role Center"
{
    layout
    {
        addfirst(rolecenter)
        {
            part(NotificationPart; Zyn_NotificationCardPart)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addlast(embedding)
        {
            action(Technician)
            {
                ApplicationArea = All;
                Caption = 'Technician';
                Image = Template;
                RunObject = page Zyn_TechnicianList;
            }
        }
    }
}