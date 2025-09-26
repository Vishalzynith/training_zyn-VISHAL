page 50176 Zyn_IncomeList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Zyn_Income;
    CardPageId = 50177;
    //Editable=false;
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(IncomeList)
            {
                field(IncomeID; Rec.IncomeID)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Category"; Rec.Category)
                {
                }
                field(Date; Rec.Date)
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(SelectCategory)
            {
                ApplicationArea = All;
                Caption = 'SelectCategory';
                RunObject = page Zyn_IncomeCategory;
            }
            action(IncomeExportFilter)
            {
                ApplicationArea = All;
                Caption = 'Export Filtered Incomes';
                RunObject = report Zyn_IncomeFilterPage;
            }
        }
    }
}