table 50161 Index
{
    fields
    {
        field(1; "Code"; Code[20]){Caption = 'Code';}
        field(2; "Description"; Text[50]){Caption = 'Description';}
        field(3; "Percentage Increase"; Decimal)
        {
            Caption = 'Percentage Inc';
            trigger OnValidate()
            begin
                RecalculateIndexValues();
            end;
        }
        field(4; "Start Year"; Integer)
        {
            Caption = 'Start Year';
            trigger OnValidate()
            begin
                RecalculateIndexValues();
            end;
        }
        field(5; "End Year";Integer)
        {
            Caption = 'End Year';
            trigger OnValidate()
            begin
                RecalculateIndexValues();
            end;
        }
    }
    keys{key(PK; Code){Clustered = true;}}
    local procedure RecalculateIndexValues()
    var
        IndexListPartRec: Record IndexCalc;
        CurValue: Decimal;
        YearCounter: Integer;
        EntryNo: Integer;
    begin
        
        if ("Start Year" = 0) or ("End Year" = 0) or ("Percentage Increase" = 0) then
            exit;
        IndexListPartRec.Reset();
        IndexListPartRec.SetRange(Code, Code);
        if IndexListPartRec.FindSet() then
            IndexListPartRec.DeleteAll();
        CurValue := 100;
        EntryNo := 0;
        for YearCounter := "Start Year" to "End Year" do begin
            EntryNo += 1;
            IndexListPartRec.Init();
            IndexListPartRec.Code := Code;
            IndexListPartRec."Entry No" := EntryNo;
            IndexListPartRec.Year := YearCounter;
            IndexListPartRec.Value := CurValue;
            IndexListPartRec.Insert();
            CurValue := CurValue + (CurValue * "Percentage Increase" / 100);
        end;
    end;
    trigger OnDelete()
    var
       
        ChildRec: Record IndexCalc;
    begin
        ChildRec.Reset();
        ChildRec.SetRange(Code, Code);
        if ChildRec.FindSet() then
            ChildRec.DeleteAll();
        
    end;
}
 