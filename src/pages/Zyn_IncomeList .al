page 50176 IncomeList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Income;
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
                field(IncomeID; Rec.IncomeID) { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field(Amount; Rec.Amount) { ApplicationArea = All; }
                field(Category; Rec.Category) { ApplicationArea = All; }
                field(Date; Rec.Date) { ApplicationArea = All; }
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
                RunObject = page "IncomeCat";
            }
            action(IncomeExportFilter)
            {
                ApplicationArea = All;
                Caption = 'Export Filtered Incomes';
                RunObject = report IncomeFilterPage; 
            }
        }
    }
}