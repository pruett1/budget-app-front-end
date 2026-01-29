//
//  MainTabView.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/29/26.
//


import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            OverviewView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Overview")
                }
            
            BudgetView()
                .tabItem {
                    Image(systemName: "chart.pie")
                    Text("Budget")
                }
            
            InvestmentsView()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Investments")
                }
            
            CashView()
                .tabItem {
                    Image(systemName: "banknote")
                    Text("Cash")
                }
            
            AccountView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Account")
                }
        }
    }
}

#Preview {
    MainTabView()
}
