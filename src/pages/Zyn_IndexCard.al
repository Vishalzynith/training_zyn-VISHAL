page 50164 "Index Card Page"
{
    PageType = Card;
    SourceTable ="Index";
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
                    ApplicationArea = All;
                }
                field("Description";Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Percentage Increase"; Rec."Percentage Increase")
                {
                    ApplicationArea = All;
                }
                field("Start Year"; Rec."Start Year")
                {
                    ApplicationArea = All;
                }
                field("End Year"; Rec."End Year")
                {
                    ApplicationArea = All;
                }
            }
            part("Calculated Value"; "IndexListPart")
            {
                SubPageLink = Code = field(Code);
                ApplicationArea = All;
            }
 
        }
 
    }   
}
 
 