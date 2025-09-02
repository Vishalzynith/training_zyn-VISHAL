page 50189 RecurringExpense
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = RecurringExpense;
    
    layout
    {
        area(Content)
        {
            repeater(RecurringList)
            {
                field(RecExpID;Rec.RecExpID) { ApplicationArea = All; }
                field(Category;Rec.Category) { ApplicationArea = All; }
                field(Amount; Rec.Amount) { ApplicationArea = All; }
                field(StartDate;Rec.StartDate) { ApplicationArea = All; }
                field(Cycle;Rec.Cycle) { ApplicationArea = All; }
                field(NextCycle;Rec.NextCycle){ApplicationArea=All;}
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
}