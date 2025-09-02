report 50161 "Sales Invoice RDLC"
{
    Caption = 'Sales Invoice RDLC';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './src/report/MyRDLReport.rdl';
    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(Name; Name) { }
            column(Address; Address) { }
            column(Picture; Picture) { }

            dataitem("SalesHeader"; "Sales Invoice Header")
            {
                column("DocumentNo"; "No.") { }
                column("CustomerNo"; "Sell-to Customer No.") { }
                column("CustomerName"; "Sell-to Customer Name") { }
                column("PostingDate"; "Posting Date") { }
                column("DocumentDate"; "Document Date") { }
                dataitem("Sales Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = field("No.");
                    column("ItemNo"; "No.") { }
                    column(Description; Description) { }
                    column(Quantity; Quantity) { }
                    column(Amount; Amount) { }
                }

                dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
                {

                    DataItemLink = "Document No." = field("No."),
                   "Customer No." = field("Sell-to Customer No.");

                    column(CustLedgerDescription; Description) { }
                    column(CustLedgerAmount; Amount) { }
                    column(CustLedgerRemainingAmt; "Remaining Amount") { }
                }


                dataitem("Begintextcode"; Subpageext)
                {
                    DataItemLinkReference = "SalesHeader";
                    DataItemTableView = sorting("No.", "Line No.") WHERE(Selection = CONST(BeginEndEnum::"Begin"));

                    DataItemLink = "No." = field("No.");
                    column("Begin"; text)
                    {
                        IncludeCaption = true;
                    }
                }
                dataitem("Endtextcode"; Subpageext)
                {
                    DataItemLinkReference = "SalesHeader";
                    DataItemTableView = sorting("No.", "Line No.") WHERE(Selection = CONST(BeginEndEnum::"End"));

                    DataItemLink = "No." = field("No.");
                    column("End"; text)
                    {
                        IncludeCaption = true;
                    }
                }


            }
        }
    }
}