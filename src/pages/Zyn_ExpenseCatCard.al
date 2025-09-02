page 50169 ExpenseCatCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = ExpenseCat;
    
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