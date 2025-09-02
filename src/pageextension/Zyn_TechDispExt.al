pageextension 50142 TechnicianDispExt extends "Business Manager Role Center"
{
    layout
    {
        addfirst(rolecenter)
        {
            part(NotificationPart; "My Notification Part")
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
                RunObject = page "Technician List";
            }
        }
    }
}