page 50167 ExpenseCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Expense;

    layout
    {
        area(Content)
        {
            group(ExpenseCard)
            {
                field(ExpenseID; Rec.ExpenseID)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    Caption = 'Category';

                    trigger OnValidate()
                    begin
                        RemainingBudgetTxt := Format(Rec.RemainingBudget());
                        CurrPage.Update();
                    end;
                }
                field(RemainingBudget; RemainingBudgetTxt)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;

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
                    ApplicationArea = All;

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
