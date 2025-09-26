pageextension 50124 "Zyn_SalesQuoteExt" extends "Sales Quote"
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
                        ExtensionTextLine: Record "Extended Text Line";
                        SubPageExtension: Record Zyn_SubpageExtension;
                        Customer: Record Customer;
                        LineNo: Integer;
                    begin
                        if Rec."No." = '' then
                            Error('Please enter or save the Sales Invoice before selecting Beginning Text.');
                        SubPageExtension.SetRange("document type", Rec."Document Type");
                        SubPageExtension.SetRange("No.", Rec."No.");
                        SubPageExtension.setrange(selection, SubPageExtension.selection::"Begin");
                        SubPageExtension.DeleteAll();

                        if Customer.Get(Rec."Sell-to Customer No.") then begin
                            ExtensionTextLine.SetRange("No.", Rec."Beginning Text");
                            ExtensionTextLine.SetRange("Language Code", Customer."Language Code");
                            LineNo := 10000;
                            repeat
                                SubPageExtension.Init();
                                SubPageExtension."Line No." := LineNo;
                                SubPageExtension.selection := SubPageExtension.selection::"Begin";
                                SubPageExtension."customer no" := Rec."Sell-to Customer No.";
                                SubPageExtension."Document Type" := Rec."Document Type";
                                SubPageExtension."No." := Rec."No.";
                                SubPageExtension."Language code" := Customer."Language Code";
                                SubPageExtension."Description" := Rec."Beginning Text";
                                SubPageExtension.Text := ExtensionTextLine."Text";
                                SubPageExtension.Insert();

                                LineNo += 10000;
                            until ExtensionTextLine.Next() = 0;

                        end;

                        CurrPage."Extended Text Part".Page.SaveRecord();
                    end;
                }
            }
            part("Extended Text Part"; Zyn_BeginListPart)
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = field("Document Type"),
                              "No." = field("No."),
                              selection = const(Zyn_BeginEndEnum::"Begin");
            }
            group("Ending Text")
            {
                field("Ending Text Code"; Rec."Ending Text")
                {
                    ApplicationArea = All;
                    TableRelation = "Standard Text";
                    trigger OnValidate()
                    var
                        ExtensionTextLine: Record "Extended Text Line";
                        SubPageExtension: Record Zyn_SubpageExtension;
                        Customer: Record Customer;
                        LineNo: Integer;
                    begin
                        if Rec."No." = '' then
                            Error('Please enter or save the Sales Invoice before selecting Beginning Text.');
                        SubPageExtension.SetRange("document type", Rec."Document Type");
                        SubPageExtension.SetRange("No.", Rec."No.");
                        SubPageExtension.setrange(selection, SubPageExtension.selection::"End");
                        SubPageExtension.DeleteAll();

                        if Customer.Get(Rec."Sell-to Customer No.") then begin
                            ExtensionTextLine.SetRange("No.", Rec."Ending Text");
                            ExtensionTextLine.SetRange("Language Code", Customer."Language Code");

                            LineNo := 10000;

                            repeat
                                SubPageExtension.Init();
                                SubPageExtension."Line No." := LineNo;
                                SubPageExtension.selection := SubPageExtension.selection::"End";
                                SubPageExtension."customer no" := Rec."Sell-to Customer No.";
                                SubPageExtension."Document Type" := Rec."Document Type";
                                SubPageExtension."No." := Rec."No.";
                                SubPageExtension."Language code" := Customer."Language Code";
                                SubPageExtension."Description" := Rec."Ending Text";
                                SubPageExtension.Text := ExtensionTextLine."Text";
                                SubPageExtension.Insert();

                                LineNo += 10000;
                            until ExtensionTextLine.Next() = 0;
                        end;
                        CurrPage."Ending Text Part".Page.SaveRecord();
                    end;
                }
            }
            part("Ending Text Part"; Zyn_EndingTextListPart)
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = field("Document Type"),
                              "No." = field("No."),
                              selection = const(Zyn_BeginEndEnum::"End");
            }
        }
    }
    var
        "Beginning Text Code": Code[20];
        "Ending Text Code": Code[20];
}
