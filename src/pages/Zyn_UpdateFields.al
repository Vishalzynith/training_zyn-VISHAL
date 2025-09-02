PAGE 50112 UpdatePage
{
    layout
    {
        area(Content)
        {
            field(TableName; TableName)
            {
                Caption = 'TableName';
                ApplicationArea = All;
                TableRelation = "AllObjWithCaption"."Object ID" where("Object Type" = const(Table));
            }
            field(FieldName; FieldName)
            {
                Caption = 'FieldName';
                ApplicationArea = All;
                DrillDown = True;
                Trigger OnDrillDown()
                var
                    RecRef: RecordRef;
                    FieldRef: FieldRef;
                    TempBuffer: Record "Field Lookup Buffer" temporary;
                    i: Integer;
                    FN: Text[250];
                begin
                    if TableName = 0 then
                        Error('Please select a table first.');
                    RecRef.Open(TableName);
                    for i := 1 to RecRef.FieldCount do begin
                        FieldRef := RecRef.FieldIndex(i);
                        TempBuffer.Init();
                        TempBuffer.ID := FieldRef.Number;
                        FN := FieldRef.Name;
                        TempBuffer."Field Name" := FN;
                        TempBuffer.Insert();
                    end;
                    RecRef.Close();
                    if Page.RunModal(Page::"Field Lookup Buffer Page", TempBuffer, selectcust) = Action::LookupOK then begin
                        FieldID := TempBuffer.ID;
                        FieldName := TempBuffer."Field Name";
                    end;
                    Message('Selected Table ID is: %1', TableName);
                end;
            }
            field(RecordSecltion; RecordSecltion)
            {
                Caption = 'Record';
                ApplicationArea = All;
                trigger OnDrillDown()
                var
                    RecRef: RecordRef;
                    FieldRef: FieldRef;
                    TempValueBuffer: Record "Field Lookup Buffer" temporary;
                    LineNo: Integer;
                    SelectedLineNo: Integer;
                    SelectedText: Text[250];
                begin
                    if (TableName = 0) OR (fieldid = 0) then
                        Error('Please select a table and field first.');
                    RecRef.Open(TableName);
                    FieldRef := RecRef.Field(fieldid);
                    LineNo := 0;
                    repeat
                        LineNo += 1;
                        TempValueBuffer.Init();
                        TempValueBuffer.ID := LineNo;
                        TempValueBuffer."Field Name" := Format(FieldRef.Value);
                        TempValueBuffer.Insert();
                    until RecRef.Next() = 0;

                    
                    if Page.RunModal(Page::"Field Lookup Buffer Page", TempValueBuffer, selectcust) = Action::LookupOK then begin
                        SelectedLineNo := TempValueBuffer.ID;
                        SelectedText := TempValueBuffer."Field Name";
                    end;
                    RecRef.Close();
                    
                    if SelectedLineNo > 0 then begin
                        LineNo := 0;
                        RecRef.Open(TableName);
                        repeat
                            LineNo += 1;
                        until (LineNo = SelectedLineNo) or (RecRef.Next() = 0);

                        RecordID := RecRef.RecordId;
                        RecordSecltion := SelectedText;
                        RecRef.Close();
                    end;
                end;
            }
            field(Value_To_Enter; Value_To_Enter)
            {
                Caption = 'New Value';
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    UpdateFieldValue();
                end;
            }
        }
    }
    var
        TableName: Integer;
        FieldName: Text[250];
        RecordSecltion: Text[250];
        Value_To_Enter: Text[250];
        TableID: Integer;
        FieldID: Integer;
        Object: Integer;
        selectcust: Integer;
        RecordID: RecordId;

    local procedure UpdateFieldValue()
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
        IntValue: Integer;
        DecValue: Decimal;
        DateValue: Date;
        RecId: RecordId;
    begin
        if TableName = 0 then
            Error('Please select a table first.');
        if FieldID = 0 then
            Error('Please select a field.');
        if RecordID.TableNo <> 0 then begin
            RecRef.Open(TableName);
            RecRef.Get(RecordID);
            FieldRef := RecRef.Field(FieldID);
            
            case FieldRef.Type of
                FieldType::Text, FieldType::Code:
                    FieldRef.Value := Value_To_Enter;
                FieldType::Integer:
                    begin
                        Evaluate(IntValue, Value_To_Enter);
                        FieldRef.Value := IntValue;
                    end;
                FieldType::Decimal:
                    begin
                        Evaluate(DecValue, Value_To_Enter);
                        FieldRef.Value := DecValue;
                    end;
                FieldType::Boolean:
                    FieldRef.Value := (Value_To_Enter = 'Yes') or (Value_To_Enter = 'TRUE');
                FieldType::Date:
                    begin
                        Evaluate(DateValue, Value_To_Enter);
                        FieldRef.Value := DateValue;
                    end;
                else
                    Error('Field type not supported for update.');
            end;
            RecRef.Modify();
            Message('Field %1 has been updated to %2 in table %3.', FieldName, Value_To_Enter, TableName);
            RecRef.Close();
        end else
            Error('Please select a record.');
    end;
}
