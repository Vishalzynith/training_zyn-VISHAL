pageextension 50123 "Zyn_SalesOrderExt" extends "Sales Order"
{
    layout
    {
        addlast(content)
        {
            group("Beginning Text")
            {
                field("Beginning Text Code"; Rec."Beginning Text")
                {
                    ApplicationArea = All;
                    TableRelation = "Standard Text";
                    trigger OnValidate()
                    var
                        ExtText: Record "Extended Text Line";
                        Buffer: Record Subpageext;
                        Customer: Record Customer;
                        LineNo: Integer;
                    begin
                        if Rec."No." = '' then
                            Error('Please enter or save the Sales Invoice before selecting Beginning Text.');
                        Buffer.SetRange("document type", Rec."Document Type");
                        Buffer.SetRange("No.", Rec."No.");
                        Buffer.setrange(selection, Buffer.selection::"Begin");
                        buffer.DeleteAll();

                        if Customer.Get(Rec."Sell-to Customer No.") then begin
                            ExtText.SetRange("No.", Rec."Beginning Text");
                            ExtText.SetRange("Language Code", Customer."Language Code");

                            LineNo := 10000;

                            repeat
                                Buffer.Init();
                                Buffer."Line No." := LineNo;
                                Buffer.selection := Buffer.selection::"Begin";
                                Buffer."customer no" := Rec."Sell-to Customer No.";
                                Buffer."Document Type" := Rec."Document Type";
                                Buffer."No." := Rec."No.";
                                Buffer."Language code" := Customer."Language Code";
                                Buffer."Description" := Rec."Beginning Text";
                                Buffer.Text := ExtText."Text";
                                Buffer.Insert();

                                LineNo += 10000;
                            until ExtText.Next() = 0;

                        end;

                        CurrPage."Extended Text Part".Page.SaveRecord();
                    end;

                }
            }

            part("Extended Text Part"; BeginListPart)
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = field("Document Type"),
                              "No." = field("No."),
                              selection = const(BeginEndEnum::"Begin");
            }

            group("Ending Text")
            {
                field("Ending Text Code"; Rec."Ending Text")
                {
                    ApplicationArea = All;
                    TableRelation = "Standard Text";
                    trigger OnValidate()
                    var
                        ExtText: Record "Extended Text Line";
                        Buffer: Record Subpageext;
                        Customer: Record Customer;
                        LineNo: Integer;
                    begin
                        if Rec."No." = '' then
                            Error('Please enter or save the Sales Invoice before selecting Beginning Text.');
                        Buffer.SetRange("document type", Rec."Document Type");
                        Buffer.SetRange("No.", Rec."No.");
                        Buffer.setrange(selection, Buffer.selection::"End");
                        buffer.DeleteAll();

                        if Customer.Get(Rec."Sell-to Customer No.") then begin
                            ExtText.SetRange("No.", Rec."Ending Text");
                            ExtText.SetRange("Language Code", Customer."Language Code");

                            LineNo := 10000;

                            repeat
                                Buffer.Init();
                                Buffer."Line No." := LineNo;
                                Buffer.selection := Buffer.selection::"End";
                                Buffer."customer no" := Rec."Sell-to Customer No.";
                                Buffer."Document Type" := Rec."Document Type";
                                Buffer."No." := Rec."No.";
                                Buffer."Language code" := Customer."Language Code";
                                Buffer."Description" := Rec."Ending Text";
                                Buffer.Text := ExtText."Text";
                                Buffer.Insert();

                                LineNo += 10000;
                            until ExtText.Next() = 0;

                        end;

                        CurrPage."Ending Text Part".Page.SaveRecord();
                    end;

                }
            }

            part("Ending Text Part"; EndListPart)
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = field("Document Type"),
                              "No." = field("No."),
                              selection = const(BeginEndEnum::"End");
            }
            

            group(InvoiceFields)
            {
                field("Beginning Invoice Code"; Rec."Beginning Invoice Text")
                {
                    ApplicationArea = All;
                }
                field("Ending Invoice Text"; Rec."Ending Invoice Text")
                {
                    ApplicationArea = All;
                }

            }
        }
        addlast(General)
        {
            field("Last Sold Price";Rec."Last Sold Price")
            {
                ApplicationArea=All;
                Caption='Last Sold Price';
            }
        }



    }

    var
        "Beginning Text Code": Code[20];
        "Ending Text Code": Code[20];
}
