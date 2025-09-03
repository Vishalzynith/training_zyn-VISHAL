page 50199 AssetTypeList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = AssetType;
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
                field(Category;Rec.Category) { ApplicationArea = All; }
                field(Name;Rec.Name) { ApplicationArea = All; }
            }
        }
        
    }
}