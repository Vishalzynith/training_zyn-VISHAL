page 50163 Zyn_IndexCheck
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Zyn_Index;
    //Editable=false;
    CardPageId = 50164;
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(IndexCheck)
            {
                field(Code; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Start Year"; Rec."Start Year")
                {
                }
                field("End Year"; Rec."End Year")
                {
                }
                field("Percentage Increase"; Rec."Percentage Increase")
                {
                }
            }
        }
    }
}