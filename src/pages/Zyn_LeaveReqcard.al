page 50280 Zyn_LeaveRequestCard
{
    Caption = 'Leave Request Card';
    PageType = Card;
    SourceTable = Zyn_LeaveRequest;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Request No."; Rec."Request No.")
                {
                }
                field("Emp Id."; Rec."Emp Id.")
                {
                    TableRelation = Zyn_Employee."Emp Id.";
                    trigger OnValidate()
                    var
                        LeaveCategory: Record Zyn_LeaveCategory;
                        LeaveLog: Record Zyn_EmployeeLeaveLog;
                        TotalUsed: Integer;
                    begin
                        if Rec.Category = Rec.Category::None then
                            exit;

                        if LeaveCategory.Get(Rec.Category) then begin
                            TotalUsed := 0;
                            LeaveLog.Reset();
                            LeaveLog.SetRange("Emp Id.", Rec."Emp Id.");
                            LeaveLog.SetRange(Category, Rec.Category);
                            if LeaveLog.FindSet() then
                                repeat
                                    TotalUsed += LeaveLog."No. of Days";
                                until LeaveLog.Next() = 0;

                            Rec."Remaining Days" := LeaveCategory."NO.of days allowed" - TotalUsed;
                            CurrPage.Update();
                        end;
                    end;
                }
                field(Category; Rec.Category)
                {
                    trigger OnValidate()
                    var
                        LeaveCategory: Record Zyn_LeaveCategory;
                        LeaveLog: Record Zyn_EmployeeLeaveLog;
                        TotalUsed: Integer;
                    begin
                        if Rec."Emp Id." = '' then
                            exit;
                        if LeaveCategory.Get(Rec.Category) then begin
                            TotalUsed := 0;
                            LeaveLog.Reset();
                            LeaveLog.SetRange("Emp Id.", Rec."Emp Id.");
                            LeaveLog.SetRange(Category, Rec.Category);
                            if LeaveLog.FindSet() then
                                repeat
                                    TotalUsed += LeaveLog."No. of Days";
                                until LeaveLog.Next() = 0;

                            Rec."Remaining Days" := LeaveCategory."NO.of days allowed" - TotalUsed;
                            CurrPage.Update();
                        end;
                    end;
                }
                field("From Date"; Rec."From Date")
                {
                    trigger OnValidate()
                    begin
                        if (Rec."From Date" <> 0D) and (Rec."To Date" <> 0D) then
                            Rec."No.of days" := Rec."To Date" - Rec."From Date" + 1;

                        CurrPage.Update();
                    end;
                }
                field("To Date"; Rec."To Date")
                {
                    trigger OnValidate()
                    begin
                        if (Rec."From Date" <> 0D) and (Rec."To Date" <> 0D) then
                            Rec."No.of days" := Rec."To Date" - Rec."From Date" + 1;

                        CurrPage.Update();
                    end;
                }
                field("No.of days"; Rec."No.of days")
                {
                    Editable = false;
                }
                field("Remaining Days"; Rec."Remaining Days")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ApproveLeave)
            {
                Caption = 'Approve Leave';
                Image = Approve;
                ApplicationArea = All;
                trigger OnAction()
                var
                    LeaveManagement: Codeunit Zyn_LeaveManagement;
                begin
                    LeaveManagement.ApproveLeaveRequest(Rec);
                    Message(ApproveLeaveMsg, Rec."Request No.");
                end;
            }
        }
    }
    var ApproveLeaveMsg: Label 'Leave Request %1 has been approved and logged.';
}
