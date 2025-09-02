// codeunit 50100 Zyn_DeleteOnSalesDelete
// {
//     [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterDeleteEvent', '', false, false)]
//     local procedure DeleteOnSalesDelete(var Rec: Record "Sales Header")
//     var
//         MyCustomTable: Record Subpageext;
//     begin
//         MyCustomTable.SetRange("Document Type", Rec."Document Type");
//         MyCustomTable.SetRange("No.", Rec."No.");
//         if not MyCustomTable.IsEmpty then
//             MyCustomTable.DeleteAll();
//     end;
// }
