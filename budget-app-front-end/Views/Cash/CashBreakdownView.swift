//
//  CashBreakdownView.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/29/26.
//

//import SwiftUI
//
//struct CashAccount: Identifiable {
//    let id = UUID()
//    let name: String
//    let balance: Double
//}
//
//struct CashBreakdownView: View {
//    let accounts: [CashAccount] = [
//        CashAccount(name: "Checking Account", balance: 1523.45),
//        CashAccount(name: "Savings Account", balance: 10450.00),
//        CashAccount(name: "Cash on Hand", balance: 300.75),
//        CashAccount(name: "Emergency Fund", balance: 5000.00)
//    ]
//    
//    var body: some View {
//        NavigationView {
//            List(accounts) { account in
//                HStack {
//                    Text(account.name)
//                    Spacer()
//                    Text(account.balance, format: .currency(code: "USD"))
//                        .foregroundColor(.green)
//                }
//                .padding(.vertical, 4)
//            }
//            .navigationTitle("Cash Breakdown")
//        }
//    }
//}
//
//struct CashBreakdownView_Previews: PreviewProvider {
//    static var previews: some View {
//        CashBreakdownView()
//    }
//}
