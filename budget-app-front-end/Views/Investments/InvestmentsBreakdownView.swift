//
//  InvestmentsBreakdownView.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/29/26.
//

//
//import SwiftUI
//
//struct Account: Identifiable {
//    let id = UUID()
//    let name: String
//    let value: Double
//}
//
//struct InvestmentsBreakdownView: View {
//    let accounts: [Account] = [
//        Account(name: "Savings Account", value: 12000.50),
//        Account(name: "Retirement Fund", value: 35000.00),
//        Account(name: "Brokerage Account", value: 18000.75),
//        Account(name: "Education Fund", value: 10000.00)
//    ]
//    
//    var body: some View {
//        NavigationView {
//            List(accounts) { account in
//                HStack {
//                    Text(account.name)
//                    Spacer()
//                    Text("$\(account.value, specifier: "%.2f")")
//                        .foregroundColor(.gray)
//                }
//                .padding(.vertical, 4)
//            }
//            .navigationTitle("Investments Breakdown")
//        }
//    }
//}
//
//#Preview {
//    InvestmentsBreakdownView()
//}
