page 50200 Zyn_AssetTypeCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Zyn_AssetType;

    layout
    {
        area(Content)
        {
            group(AssetTypeCard)
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
