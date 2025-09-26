table 50184 Zyn_ExpenseClaim
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; ID; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            AutoIncrement = true;
        }
        field(2; EmpID; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Zyn_Employee."Emp Id.";
            trigger OnValidate()
            begin
                if (CategoryID <> 0) and (ClaimDate <> 0D) then
                    CalcRemainingLimit();
            end;
        }
        field(3; CategoryID; Integer)
        {
            Caption = 'Category';
            TableRelation = Zyn_ExpenseCategory.CategoryID WHERE(EmpID = FIELD(EmpID));
            trigger OnValidate()
            var
                Cat: Record Zyn_ExpenseCategory;
            begin
                if (EmpID <> '') and Cat.Get(CategoryID) then begin
                    if Cat.EmpID <> EmpID then
                        Error('Category does not belong to this Employee.');
                    SubType := Cat.SubType;
                    Category := Cat.Code;
                    CategoryName := Cat.Name;
                    if ClaimDate <> 0D then
                        CalcRemainingLimit();
                end;
            end;
        }
        field(4; Category; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Category Code';
        }
        field(5; CategoryName; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Category Name';
        }
        field(6; SubType; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sub Type';
        }
        field(7; ClaimDate; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Duplicate: Record Zyn_ExpenseClaim;
            begin
                if (ClaimDate <> 0D) and (EmpID <> '') and (CategoryID <> 0) then begin
                    Duplicate.Reset();
                    Duplicate.SetRange(EmpID, EmpID);
                    Duplicate.SetRange(CategoryID, CategoryID);
                    Duplicate.SetRange(Category, Category);
                    Duplicate.SetRange(CategoryName, CategoryName);
                    Duplicate.SetRange(SubType, SubType);
                    Duplicate.SetRange(ClaimDate, ClaimDate);

                    if Duplicate.FindFirst() then begin
                        if Duplicate.ID <> Rec.ID then
                            Error(
                              'Duplicate claim not allowed. Employee %1 already has a claim for Category %2 (%3,%4,%5) on %6.',
                              EmpID, CategoryID, Category, CategoryName, SubType, ClaimDate
                            );
                    end;
                end;
                if (EmpID <> '') and (CategoryID <> 0) then
                    CalcRemainingLimit();
            end;
        }
        field(8; BillDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if ClaimDate = 0D then
                    Error('Please enter Claim Date before entering Amount.');

                if (Amount > RemainingLimit) then
                    Error(
                        'Amount %1 exceeds remaining yearly limit %2 for Employee %3 in Category %4.',
                        Amount, RemainingLimit, EmpID, CategoryID
                    );
            end;
        }
        field(10; Status; Enum Zyn_Status)
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }
        field(11; Bill; Blob)
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill (Attachment)';
            Subtype = Bitmap;
        }
        field(12; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13; RemainingLimit; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Remaining Limit';
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
    var
        ClaimRec: Record Zyn_ExpenseClaim;
        ExpCat: Record Zyn_ExpenseCategory;

    procedure CalcRemainingLimit()
    var
        UsedAmount: Decimal;
        YearStart: Date;
        YearEnd: Date;
    begin
        if (EmpID = '') or (CategoryID = 0) or (ClaimDate = 0D) then
            exit;

        if not ExpCat.Get(CategoryID) then
            exit;
        // Setting year
        YearStart := DMY2Date(1, 1, Date2DMY(ClaimDate, 3));
        YearEnd := DMY2Date(31, 12, Date2DMY(ClaimDate, 3));

        UsedAmount := 0;
        ClaimRec.Reset();
        ClaimRec.SetRange(EmpID, EmpID);
        ClaimRec.SetRange(CategoryID, CategoryID);
        ClaimRec.SetRange(Status, Status::Approved);
        ClaimRec.SetRange(ClaimDate, YearStart, YearEnd);

        if ClaimRec.FindSet() then
            repeat
                if ClaimRec.ID <> Rec.ID then
                    UsedAmount += ClaimRec.Amount;
            until ClaimRec.Next() = 0;
        Rec.RemainingLimit := ExpCat.Limit - UsedAmount;
        if Rec.RemainingLimit < 0 then
            Rec.RemainingLimit := 0;
        Modify(true);
    end;
}