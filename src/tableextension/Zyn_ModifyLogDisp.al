tableextension 50110 Zyn_CustomerModify extends Customer
{
    trigger OnBeforeModify()
    var
        RecRef, xRecRef: RecordRef;
        FieldRef, xFieldRef: FieldRef;
        LogEntry: Record Zyn_ModifyLog;
        i: Integer;
        FieldName: Text;
    begin
        RecRef.GetTable(Rec);
        xRecRef.GetTable(xRec);
 
        for i := 1 to RecRef.FieldCount do begin
            FieldRef := RecRef.FieldIndex(i);
            xFieldRef := xRecRef.FieldIndex(i);
            FieldName := FieldRef.Name;
                    begin
                        if Format(FieldRef.Value) <> Format(xFieldRef.Value) then begin
                            LogEntry.Init();
                            LogEntry."Entry No" := 0;
                            LogEntry."Customer No" := Rec."No.";
                            LogEntry."Field Name" := FieldRef.Caption();
                            LogEntry."Prev Value" := Format(xFieldRef.Value);
                            LogEntry."Updated Value" := Format(FieldRef.Value);
                            LogEntry."Modified By" := UserId();
                            LogEntry.Insert();
                        end;
                    end;
            end;
        end;
}
 
 