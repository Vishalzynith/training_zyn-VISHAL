table 50179 Zyn_Plans
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; PlanID; Code[20]) { DataClassification = ToBeClassified; }
        field(2; Fee; Decimal) { DataClassification = ToBeClassified; }
        field(3; Name; Text[50]) { DataClassification = ToBeClassified; }
        field(4; Status; Enum Zyn_PlanEnum) { DataClassification = ToBeClassified; }
    }

    keys
    {
        key(PK; PlanID) { Clustered = true; }
    }

    trigger OnModify()
    var
        SubscriptionRec: Record Zyn_Subscription;
    begin
        if Rec.Status = Rec.Status::Inactive then begin
            SubscriptionRec.Reset();
            SubscriptionRec.SetRange(PlanID, Rec.PlanID);
            if SubscriptionRec.FindSet() then
                repeat
                    SubscriptionRec.Delete(true);
                until SubscriptionRec.Next() = 0;
        end;
    end;
}
