page 50159 "Customer Open Docs FactBox"
{
    PageType = CardPart; 
    SourceTable = Customer; 
    ApplicationArea = All;
    Caption = 'Open Documents';
    Editable = false;
 
    layout
    {
        area(content)
        {
            cuegroup("Sales Documents")
            {
                field(OpenSalesInvoices; OpenSalesInvoices)
                {
                    Caption = 'Open Sales Invoices';
                    ApplicationArea = All;
                    DrillDown = true;
 
                    trigger OnDrillDown()
                    var
                        SalesInvoice: Record "Sales Header";
                    begin
                        SalesInvoice.SetRange("Bill-to Customer No.", Rec."No.");
                        SalesInvoice.SetRange("Document Type", SalesInvoice."Document Type"::Invoice);
                        SalesInvoice.SetRange(Status, SalesInvoice.Status::Open);
                        Page.Run(Page::"Sales Invoice List", SalesInvoice);
                    end;
                }
 
                field(OpenSalesOrders; OpenSalesOrders)
                {
                    Caption = 'Open Sales Orders';
                    ApplicationArea = All;
                    DrillDown = true;
 
                    trigger OnDrillDown()
                    var
                        SalesOrder: Record "Sales Header";
                    begin
                        SalesOrder.SetRange("Sell-to Customer No.", Rec."No.");
                        SalesOrder.SetRange("Document Type", SalesOrder."Document Type"::Order);
                        SalesOrder.SetRange(Status, SalesOrder.Status::Open);
                        Page.Run(Page::"Sales Order List", SalesOrder);
                    end;
                }
            }
        }
    }
 
    var
        OpenSalesInvoices: Integer;
        OpenSalesOrders: Integer;
 
    trigger OnAfterGetRecord()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("Bill-to Customer No.", Rec."No.");
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.SetRange(Status, SalesHeader.Status::Open);
        OpenSalesInvoices := SalesHeader.Count();
 
        SalesHeader.Reset();
        SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange(Status, SalesHeader.Status::Open);
        OpenSalesOrders := SalesHeader.Count();
    end;
}
 