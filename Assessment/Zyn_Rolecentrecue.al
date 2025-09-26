//Line 90-102 : Subscription Notification Task
page 50213 Zyn_SubscriptionCueCard
{
    PageType = CardPart;
    ApplicationArea = All;
    Caption = 'Subscription Dashboard';

    layout
    {
        area(content)
        {
            cuegroup(Subscriptions)
            {
                Caption = 'Subscriptions';

                field("Active Subscriptions"; ActiveSubs)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        SubRec: Record Zyn_Subscription;
                    begin
                        SubRec.SetRange(Status, SubRec.Status::Active);
                        Page.Run(Page::Zyn_SubscriptionList, SubRec);
                    end;
                }

                field("Subscription Revenue This Month"; RevenueThisMonth)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        SalesHdr: Record "Sales Header";
                        StartDate: Date;
                        EndDate: Date;
                    begin
                        StartDate := DMY2Date(1, Date2DMY(WorkDate(), 2), Date2DMY(WorkDate(), 3));
                        EndDate := WorkDate();

                        SalesHdr.SetRange("Document Type", SalesHdr."Document Type"::Invoice);
                        SalesHdr.SetRange("Document Date", StartDate, EndDate);
                        SalesHdr.SetFilter("Subscription ID", '<>%1', '');

                        Page.Run(Page::"Sales Invoice List", SalesHdr);
                    end;
                }
            }
        }
    }

    var
        ActiveSubs: Integer;
        RevenueThisMonth: Decimal;

    trigger OnAfterGetRecord()
    var
        SubRec: Record Zyn_Subscription;
        SalesHdr: Record "Sales Header";
        StartDate: Date;
        EndDate: Date;
        totalamnt: Decimal;

    begin
        NotificationMgt.SendReminder(SubRec);
        SubRec.SetRange(Status, SubRec.Status::Active);
        ActiveSubs := SubRec.Count();

        StartDate := DMY2Date(1, Date2DMY(WorkDate(), 2), Date2DMY(WorkDate(), 3));
        EndDate := WorkDate();

        SalesHdr.SetRange("Document Type", SalesHdr."Document Type"::Invoice);
        SalesHdr.SetRange("Document Date", StartDate, EndDate);
        SalesHdr.SetFilter("Subscription ID", '<>%1', '');
        totalamnt := 0;
        if SalesHdr.FindSet() then begin
            SalesHdr.CalcFields(Amount);
            repeat

                totalamnt += SalesHdr.Amount;
            until SalesHdr.Next() = 0
        end;



        RevenueThisMonth := totalamnt;
    end;
    //Subscription Notification Task
    var
        NotificationMgt: Codeunit Zyn_SubscriptionRenewal;
        SubRec: Record Zyn_Subscription;

    trigger OnOpenPage()
    var
        SubRec: Record Zyn_Subscription;
    begin
        SubRec.SetRange(Status, SubRec.Status::Active);
        if SubRec.FindSet() then
            repeat
                NotificationMgt.SendReminder(SubRec);
            until SubRec.Next() = 0;
    end;

}

