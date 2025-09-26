page 50167 Zyn_ExpenseCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Zyn_Expense;
    layout
    {
        area(Content)
        {
            group(ExpenseCard)
            {
                field(ExpenseID; Rec.ExpenseID)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Category; Rec.Category)
                {
                    Caption = 'Category';

                    trigger OnValidate()
                    begin
                        RemainingBudgetTxt := Format(Rec.RemainingBudget());
                        CurrPage.Update();
                    end;
                }
                field(RemainingBudget; RemainingBudgetTxt)
                {
                    Editable = false;
                }

                field(Amount; Rec.Amount)
                {
                    trigger OnValidate()
                    var
                        Remaining: Decimal;
                    begin
                        Remaining := Rec.RemainingBudget();
                        if Rec.Amount > Remaining then
                            Error('You cannot exceed the remaining budget. Remaining: %1', Remaining);

                        RemainingBudgetTxt := Format(Remaining);
                        CurrPage.Update();
                    end;
                }

                field(Date; Rec.Date)
                {
                    trigger OnValidate()
                    begin
                        RemainingBudgetTxt := Format(Rec.RemainingBudget());
                        CurrPage.Update();
                    end;
                }
            }
        }
    }
    var
        RemainingBudgetTxt: Text[50];

    trigger OnAfterGetRecord()
    begin
        RemainingBudgetTxt := Format(Rec.RemainingBudget());
    end;

    trigger OnAfterGetCurrRecord()
    begin
        RemainingBudgetTxt := Format(Rec.RemainingBudget());
    end;
}
