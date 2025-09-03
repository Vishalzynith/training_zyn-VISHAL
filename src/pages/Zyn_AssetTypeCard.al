page 50200 AssetTypeCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = AssetType;

    layout
    {
        area(Content)
        {
            group(AssetTypeCard)
            {
                field(Category; Rec.Category) { ApplicationArea = All; }
                field(Name;Rec.Name) { ApplicationArea = All; }
            }
        }
    }
}
