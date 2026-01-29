//
//  OverviewView.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/29/26.
//


import SwiftUI

struct OverviewView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Net Worth Card
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.blue.opacity(0.2))
                .frame(height: 120)
                .overlay(
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Net Worth")
                            .font(.headline)
                        Text("$125,000")
                            .font(.largeTitle)
                            .bold()
                        // TODO: Load net worth data from API
                    }
                    .padding()
                )
            
            // Budget Remaining Card
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.green.opacity(0.2))
                .frame(height: 120)
                .overlay(
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Budget Remaining")
                            .font(.headline)
                        Text("$3,450")
                            .font(.largeTitle)
                            .bold()
                        // TODO: Load budget remaining data from API
                    }
                    .padding()
                )
            
            // Top 3 Categories Card
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.orange.opacity(0.2))
                .frame(height: 180)
                .overlay(
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Top 3 Categories")
                            .font(.headline)
                        VStack(alignment: .leading, spacing: 6) {
                            Text("1. Groceries - $400")
                            Text("2. Utilities - $350")
                            Text("3. Entertainment - $300")
                        }
                        .font(.subheadline)
                        // TODO: Load top categories data from API
                    }
                    .padding()
                )
        }
        .padding()
    }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewView()
    }
}
