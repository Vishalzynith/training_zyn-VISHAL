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
        field(34; EmpID; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employ Table"."Emp Id.";
        }
        field(2; CategoryID; Integer)
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
                end;
            end;
        }
        field(3; Category; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Category Code';
        }
        field(4; CategoryName; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Category Name';
        }
        field(5; SubType; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sub Type';
        }
        field(6; ClaimDate; Date)
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
                              'Duplicate claim not allowed. Employee %1 already has a claim for Category %2 (%3 - %4, %5) on %6. [Existing Claim ID: %7]',
                              EmpID, CategoryID, Category, CategoryName, SubType, ClaimDate, Duplicate.ID
                            );
                    end;
                end;
            end;
        }

        field(7; BillDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ExpCat: Record Zyn_ExpenseCategory;
                UsedAmount: Decimal;
                OldClaim: Record Zyn_ExpenseClaim;
            begin
                if CategoryID = 0 then
                    Error('Please select a Category before entering Amount.');

                if not ExpCat.Get(CategoryID) then
                    Error('Expense Category not found for ID %1.', CategoryID);

                if ExpCat.EmpID <> EmpID then
                    Error('This category does not belong to employee %1.', EmpID);

                // Calculating FlowField 
                ExpCat.CalcFields("ClaimedAmount");
                UsedAmount := ExpCat."ClaimedAmount";
                if Rec.ID <> 0 then begin
                    if OldClaim.Get(Rec.ID) then
                        UsedAmount := UsedAmount - OldClaim.Amount;
                end;
                if (UsedAmount + Amount) > ExpCat.Limit then
                    Error(
                        'Amount %1 exceeds available limit %2 for this category (Total Limit: %3, Already Used: %4).',
                        Amount, ExpCat.Limit - UsedAmount, ExpCat.Limit, UsedAmount
                    );
            end;
        }
        field(9; Status; Enum Zyn_Status)
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }
        field(10; Bill; Blob)
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill (Attachment)';
            Subtype = Bitmap;
        }
        field(11; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
}
