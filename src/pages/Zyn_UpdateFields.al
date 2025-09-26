PAGE 50112 Zyn_UpdatePage
{
    ApplicationArea=All;
    layout
    {
        area(Content)
        {
            field(TableName; TableName)
            {
                Caption = 'TableName';
                TableRelation = "AllObjWithCaption"."Object ID" where("Object Type" = const(Table));
            }
            field(FieldName; FieldName)
            {
                Caption = 'FieldName';
                DrillDown = True;
                Trigger OnDrillDown()
                var
                    RecordRef: RecordRef;
                    FieldRef: FieldRef;
                    FieldLookUpBufferTemp: Record Zyn_FieldLookupBuffer temporary;
                    i: Integer;
                    FieldName: Text[250];
                begin
                    if TableName = 0 then
                        Error('Please select a table first.');
                    RecordRef.Open(TableName);
                    for i := 1 to RecordRef.FieldCount do begin
                        FieldRef := RecordRef.FieldIndex(i);
                        FieldLookUpBufferTemp.Init();
                        FieldLookUpBufferTemp.ID := FieldRef.Number;
                        FieldName := FieldRef.Name;
                        FieldLookUpBufferTemp."Field Name" := FieldName;
                        FieldLookUpBufferTemp.Insert();
                    end;
                    RecordRef.Close();
                    if Page.RunModal(Page::Zyn_FieldLookupBufferPage, FieldLookUpBufferTemp, selectcust) = Action::LookupOK then begin
                        FieldID := FieldLookUpBufferTemp.ID;
                        FieldName := FieldLookUpBufferTemp."Field Name";
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
                    RecordRef: RecordRef;
                    FieldRef: FieldRef;
                    TempValueBuffer: Record Zyn_FieldLookupBuffer temporary;
                    LineNo: Integer;
                    SelectedLineNo: Integer;
                    SelectedText: Text[250];
                begin
                    if (TableName = 0) OR (fieldid = 0) then
                        Error(TableErr);
                    RecordRef.Open(TableName);
                    FieldRef := RecordRef.Field(fieldid);
                    LineNo := 0;
                    repeat
                        LineNo += 1;
                        TempValueBuffer.Init();
                        TempValueBuffer.ID := LineNo;
                        TempValueBuffer."Field Name" := Format(FieldRef.Value);
                        TempValueBuffer.Insert();
                    until RecordRef.Next() = 0;

                    if Page.RunModal(Page::Zyn_FieldLookupBufferPage, TempValueBuffer, selectcust) = Action::LookupOK then begin
                        SelectedLineNo := TempValueBuffer.ID;
                        SelectedText := TempValueBuffer."Field Name";
                    end;
                    RecordRef.Close();

                    if SelectedLineNo > 0 then begin
                        LineNo := 0;
                        RecordRef.Open(TableName);
                        repeat
                            LineNo += 1;
                        until (LineNo = SelectedLineNo) or (RecordRef.Next() = 0);

                        RecordID := RecordRef.RecordId;
                        RecordSecltion := SelectedText;
                        RecordRef.Close();
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
    local procedure UpdateFieldValue()
    var
        RecordRef: RecordRef;
        FieldRef: FieldRef;
        IntValue: Integer;
        DecValue: Decimal;
        DateValue: Date;
        RecId: RecordId;
    begin
        if TableName = 0 then
            Error(TableErr);
        if FieldID = 0 then
            Error(FieldErr);
        if RecordID.TableNo <> 0 then begin
            RecordRef.Open(TableName);
            RecordRef.Get(RecordID);
            FieldRef := RecordRef.Field(FieldID);

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
                    Error(FieldUpdateErr);
            end;
            RecordRef.Modify();
            Message('Field %1 has been updated to %2 in table %3.', FieldName, Value_To_Enter, TableName);
            RecordRef.Close();
        end else
            Error('Please select a record.');
    end;
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
        TableErr: Label 'Please select a table first.'; 
        FieldErr: Label 'Please select a field first.';
        FieldUpdateErr:Label 'Field type not supported for update.';

}
