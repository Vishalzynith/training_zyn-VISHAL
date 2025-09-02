page 50163 IndexCheck
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Index;
    //Editable=false;
    CardPageId=50164;
    InsertAllowed=false;
    ModifyAllowed=false;
    layout
    {
        area(Content)
        {
            repeater(IndexCheck)
            {
                field(Code; Rec.Code){ApplicationArea=All;}
                field(Description;Rec.Description){ApplicationArea=All;}
                field("Start Year";Rec."Start Year"){ ApplicationArea=All;}
                field("End Year";Rec."End Year"){ ApplicationArea=All;}
                field("Percentage Increase";Rec."Percentage Increase"){ApplicationArea=All;}
            }
        }
       
    }
}