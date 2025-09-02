page 50179 IncomeCatCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = IncomeCat;
    
    layout
    {
        area(Content)
        {
                field(CategoryNo;Rec.CategoryNo){ApplicationArea=All;}
                field(Name;Rec.Name){ ApplicationArea=All;}
                field(Description;Rec.Description){ ApplicationArea=All;}
        }
        area(Factboxes)
        {
            
        }
    }
}