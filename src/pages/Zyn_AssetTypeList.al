page 50199 Zyn_AssetTypeList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Zyn_AssetType;
    CardPageId = 50200;
    //Editable=false;
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(AssetList)
            {
                field(Category; Rec.Category)
                {
                    Caption = 'Category';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                }
            }
        }

    }
}