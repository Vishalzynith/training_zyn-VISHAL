pageextension 50119 Zyn_CompanyListExt extends Companies
{
    actions
    {
        addlast(processing)
        {
            action(UpdateFields)
            {
                ApplicationArea = All;
                Caption = 'Update Fields';
                RunObject = page Zyn_UpdatePage;
            }
        }
    }
}