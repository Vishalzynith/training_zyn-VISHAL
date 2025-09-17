codeunit 50220 Zyn_ExpenseClaimManagement
{
    local procedure ValidateAmount(var Claim: Record Zyn_ExpenseClaim)
    var
        ExpCat: Record Zyn_ExpenseCategory;
    begin
        if not ExpCat.Get(Claim.CategoryID) then
            Error('Expense Category not found for ID %1.', Claim.CategoryID);

        if ExpCat.EmpID <> Claim.EmpID then
            Error('This category does not belong to employee %1.', Claim.EmpID);

        //Fetching value from amount
        ExpCat.CalcFields("ClaimedAmount"); 

        if Claim.Amount > (ExpCat.Limit - ExpCat."ClaimedAmount") then
            Error(
                'Amount %1 exceeds available limit %2 for this category (Total Limit: %3, Already Used: %4).',
                Claim.Amount, ExpCat.Limit - ExpCat."ClaimedAmount", ExpCat.Limit, ExpCat."ClaimedAmount"
            );
    end;
    local procedure Validatebill(var Claim: Record "Zyn_ExpenseClaim"; Months: Integer)
    var
        MaxAllowed: Date;
    begin
        if Claim.BillDate = 0D then
            Error('Bill Date must be provided.');
        //BillDate + Months
        MaxAllowed := CalcDate('<+' + Format(Months) + 'M>', Claim.BillDate);

        //Claimdate is within range or not
        if (Claim.ClaimDate < Claim.BillDate) or (Claim.ClaimDate > MaxAllowed) then
            Error('Claim Date (%1) must be within %2 months from Bill Date (%3)',
                Claim.ClaimDate, Months, Claim.BillDate);
    end;
    local procedure CheckDuplicateRecord(var Claim: Record Zyn_ExpenseClaim)
    var
        Duplicate: Record Zyn_ExpenseClaim;
    begin
        Duplicate.SetRange(EmpID, Claim.EmpID);
        Duplicate.SetRange(CategoryID, Claim.CategoryID);
        Duplicate.SetRange(SubType, Claim.SubType);
        Duplicate.SetRange(ClaimDate, Claim.ClaimDate);
        if Duplicate.FindFirst() then
            if Duplicate.ID <> Claim.ID then
                Error(
                    'Duplicate claim exists for Employee %1, Category %2, SubType %3 on %4 ',
                    Claim.EmpID, Claim.CategoryID, Claim.SubType, Claim.ClaimDate
                );
    end;
    procedure ApproveClaim(var Claim: Record Zyn_ExpenseClaim)
    begin
        if Claim.Status <> Claim.Status::Pending then
            Error('Only pending claims can be approved.');
        Validateamount(Claim);
        Validatebill(Claim, 3);
        CheckDuplicateRecord(Claim);
        Claim.Status := Claim.Status::Approved;
    end;
    procedure RejectClaim(var Claim: Record Zyn_ExpenseClaim)
    begin
        if Claim.Status <> Claim.Status::Pending then
            Error('Only pending claims can be rejected.');
        Validateamount(Claim);
        Validatebill(Claim, 3);
        //CheckDuplicateRecord(Claim);
        Claim.Status := Claim.Status::Rejected;
    end;
    procedure CancelClaim(var Claim: Record Zyn_ExpenseClaim)
    begin
        if Claim.Status <> Claim.Status::Pending then
            Error('Only pending claims can be cancelled.');
        Validateamount(Claim);
        Validatebill(Claim, 3);
        //CheckDuplicateRecord(Claim);
        Claim.Status := Claim.Status::Cancelled;
    end;
}
