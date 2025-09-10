//line 42-59 assessment
page 50209 Zyn_Rolecentre
{
    PageType = RoleCenter;
    ApplicationArea = All;
    Caption = 'Role Centre';
    SourceTable = Customer;
    layout
    {
        area(RoleCenter)
        {
            group(Controlgroup)
            {
                Caption = 'Customer Dashboard';
            }
            part(Cues; "Customer Cue Card")
            {
                ApplicationArea = All;
            }
            part(SubscriptionCues; "Zyn Subscription Cue Card")
            {
                ApplicationArea = All;
            }

        }
    }
    actions
    {
        area(embedding)
        {

            action("Customers")
            {
                ApplicationArea = All;

                Caption = 'Customer list';
                RunObject = page "Customer list";
            }

        }
        area(sections)
        {
            //Assessment Pointing out
            group("Plan~Subscription")
            {
                Caption = 'Plan~Subscription';
                action("Plans")
                {
                    Caption = 'Plans';
                    ApplicationArea = All;
                    RunObject = page PlanList;
                }
                action("Subscription")
                {
                    Caption = 'Subscription';
                    ApplicationArea = All;
                    RunObject = page SubscriptionList;
                }
            }
            group("Assets")
            {
                Caption = 'Assets';

                action("Asset List")
                {
                    Caption = 'Asset List';
                    ApplicationArea = All;
                    RunObject = page "AssetList";
                }
                action("Employee List")
                {
                    Caption = 'Employee List';
                    ApplicationArea = All;
                    RunObject = page "Employee List page";
                }

                action("Employee Assets")
                {
                    Caption = 'Employee Assets';
                    ApplicationArea = All;
                    RunObject = page "Zyn_EmpAssetList";
                }
            }
            group("Leave Management")
            {
                Caption = 'Leave Management';
                action("Leave Category")
                {
                    Caption = 'Leave Category';
                    ApplicationArea = All;
                    RunObject = page "Leave Cat List page";
                }
                action("Leave Request")
                {
                    Caption = 'Leave Request';
                    ApplicationArea = All;
                    RunObject = page "Leave Req List page";
                }
            }
            group("Expenses")
            {
                Caption = 'Expenses';
                action("Expense Category")
                {
                    Caption = 'Expense Category';
                    ApplicationArea = All;
                    RunObject = page ExpenseCat;
                }
                action("Expense List")
                {
                    Caption = 'Expense List';
                    ApplicationArea = All;
                    RunObject = page ExpenseList;
                }
                action("Recurring Expense")
                {
                    Caption = 'Recurring Expense';
                    ApplicationArea = All;
                    RunObject = page RecurringExpense;
                }
            }
            group("Budget~Income")
            {
                Caption = 'Budget~Income';
                action("Budget List")
                {
                    Caption = 'Budget List';
                    ApplicationArea = All;
                    RunObject = page BudgetList;
                }
                action("Income Category")
                {
                    Caption = 'Income Category';
                    ApplicationArea = All;
                    RunObject = page IncomeCat;
                }
                action("Income List")
                {
                    Caption = 'Income List';
                    ApplicationArea = All;
                    RunObject = page IncomeList;
                }
            }
        }
    }
    var
        CustomerRec: Record Customer;
    

}