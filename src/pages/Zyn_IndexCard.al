page 50164 Zyn_IndexCard
{
    PageType = Card;
    SourceTable =Zyn_Index;
    ApplicationArea = ALL;
    Caption = 'Index Card';
    layout
    {
        area(content)
        {
            group(IndexCard)
            {
                field("Code"; Rec.Code)
                {
                }
                field("Description";Rec.Description)
                {
                }
                field("Percentage Increase"; Rec."Percentage Increase")
                {
                }
                field("Start Year"; Rec."Start Year")
                {
                }
                field("End Year"; Rec."End Year")
                {
                }
            }
            part("Calculated Value"; Zyn_IndexListPart)
            {
                SubPageLink = Code = field(Code);
                ApplicationArea = All;
            }
        }
    }   
}
 
 