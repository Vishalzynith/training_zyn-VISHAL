page 50280 "Leave Req Card Page"
{
    Caption = 'Leave Request Card';
    PageType = Card;
    SourceTable = "LeaveRequest";
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
                    ApplicationArea = All;
                }
                field("Emp Id."; Rec."Emp Id.")
                {
                    ApplicationArea = All;
                    TableRelation = "Employ Table"."Emp Id.";

                    trigger OnValidate()
                    var
                        LeaveCat: Record "leave Category";
                        LeaveLog: Record "Employee Leave Log";
                        TotalUsed: Integer;
                    begin
                        if Rec.Category = Rec.Category::None then
                            exit; 

                        if LeaveCat.Get(Rec.Category) then begin
                            TotalUsed := 0;
                            LeaveLog.Reset();
                            LeaveLog.SetRange("Emp Id.", Rec."Emp Id.");
                            LeaveLog.SetRange(Category, Rec.Category);
                            if LeaveLog.FindSet() then
                                repeat
                                    TotalUsed += LeaveLog."No. of Days";
                                until LeaveLog.Next() = 0;

                            Rec."Remaining Days" := LeaveCat."NO.of days allowed" - TotalUsed;
                            CurrPage.Update();
                        end;
                    end;
                }

                field(Category; Rec.Category)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        LeaveCat: Record "leave Category";
                        LeaveLog: Record "Employee Leave Log";
                        TotalUsed: Integer;
                    begin
                        if Rec."Emp Id." = '' then
                            exit; 

                        if LeaveCat.Get(Rec.Category) then begin
                            TotalUsed := 0;
                            LeaveLog.Reset();
                            LeaveLog.SetRange("Emp Id.", Rec."Emp Id.");
                            LeaveLog.SetRange(Category, Rec.Category);
                            if LeaveLog.FindSet() then
                                repeat
                                    TotalUsed += LeaveLog."No. of Days";
                                until LeaveLog.Next() = 0;

                            Rec."Remaining Days" := LeaveCat."NO.of days allowed" - TotalUsed;
                            CurrPage.Update();
                        end;
                    end;
                }

                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if (Rec."From Date" <> 0D) and (Rec."To Date" <> 0D) then
                            Rec."No.of days" := Rec."To Date" - Rec."From Date" + 1;

                        CurrPage.Update();
                    end;
                }

                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if (Rec."From Date" <> 0D) and (Rec."To Date" <> 0D) then
                            Rec."No.of days" := Rec."To Date" - Rec."From Date" + 1;

                        CurrPage.Update();
                    end;
                }

                field("No.of days"; Rec."No.of days")
                {
                    ApplicationArea = All;
                    Editable = false; 
                }
                field("Remaining Days"; Rec."Remaining Days")
                {
                    ApplicationArea = All;
                    Editable = false; 
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
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
                    LeaveMgt: Codeunit "Leave Management";
                begin
                    LeaveMgt.ApproveLeaveRequest(Rec);
                    Message('Leave Request %1 has been approved and logged.', Rec."Request No.");
                end;
            }
        }
    }
}
