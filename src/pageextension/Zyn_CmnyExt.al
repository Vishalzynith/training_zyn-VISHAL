pageextension 50119 CompanyListExt extends Companies
{
    actions
    {
        addlast(processing)
        {
            action(UpdateFields)
            {
                ApplicationArea = All;
                Caption = 'Update Fields';
                RunObject = page "UpdatePage";
            }
        }
    }
}