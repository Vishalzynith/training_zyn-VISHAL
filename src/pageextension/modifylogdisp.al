
// pageextension 50120 CustModifyExt extends "Customer Card"
// {
//     actions
//     {
//         addlast(processing)
//         {
//             action(ModifyLog)
//             {
//                 ApplicationArea = All;
//                 Caption = 'Modify Log';
//                 Image = Edit;
//                 RunObject = page "Modify Log List";
//                 RunPageLink = "Customer No"=field("No.");
//             }
//         }

//     }
// }
