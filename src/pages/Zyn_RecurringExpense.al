page 50189 Zyn_RecurringExpense
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Recurring Expense';
    UsageCategory = Lists;
    SourceTable = Zyn_RecurringExpense;
    layout
    {
        area(Content)
        {
            repeater(RecurringList)
            {
                field(RecExpID; Rec.RecExpID)
                {
                }
                field(Category; Rec.Category)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(StartDate; Rec.StartDate)
                {
                }
                field(Cycle; Rec.Cycle)
                {
                }
                field(NextCycle; Rec.NextCycle)
                {
                }
            }
        }
    }
}