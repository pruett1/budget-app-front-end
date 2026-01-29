//
//  BudgetView.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/29/26.
//


import SwiftUI
import Charts

struct BudgetView: View {
    // Mock data for 50/30/20 budget breakdown
    struct BudgetCategory: Identifiable {
        let id = UUID()
        let name: String
        let percentage: Double
        let color: Color
    }

    let budgetData: [BudgetCategory] = [
        BudgetCategory(name: "Needs", percentage: 50, color: .blue),
        BudgetCategory(name: "Wants", percentage: 30, color: .green),
        BudgetCategory(name: "Savings", percentage: 20, color: .orange)
    ]

    var body: some View {
        VStack(spacing: 30) {
            Button("Create/Edit Budget") {
                // TODO: Implement button action for creating/editing budget
            }
            .padding()
            .background(Color.accentColor.opacity(0.2))
            .cornerRadius(8)

            if #available(iOS 16.0, macOS 13.0, *) {
                // Swift Charts pie chart placeholder
                Chart {
                    ForEach(budgetData) { category in
                        SectorMark(
                            angle: .value("Percentage", category.percentage),
                            innerRadius: .ratio(0.5),
                            angularInset: 1.0
                        )
                        .foregroundStyle(category.color)
                        .annotation() {
//                            position: AnnotationPosition = .center;
//                            alignment: Alignment = .center;
                            Text("\(Int(category.percentage))%")
                                .font(.caption)
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                }
                .frame(height: 200)
                .chartLegend(.visible)
                .padding()
            } else {
                // Fallback simple circular progress-like shapes for lower versions
                ZStack {
                    Circle()
                        .trim(from: 0, to: CGFloat(budgetData[0].percentage / 100))
                        .stroke(budgetData[0].color, lineWidth: 40)
                        .rotationEffect(.degrees(-90))
                    Circle()
                        .trim(from: CGFloat(budgetData[0].percentage / 100), to: CGFloat((budgetData[0].percentage + budgetData[1].percentage) / 100))
                        .stroke(budgetData[1].color, lineWidth: 40)
                        .rotationEffect(.degrees(-90))
                    Circle()
                        .trim(from: CGFloat((budgetData[0].percentage + budgetData[1].percentage) / 100), to: 1)
                        .stroke(budgetData[2].color, lineWidth: 40)
                        .rotationEffect(.degrees(-90))

                    VStack {
                        Text("50% Needs")
                            .foregroundColor(budgetData[0].color)
                        Text("30% Wants")
                            .foregroundColor(budgetData[1].color)
                        Text("20% Savings")
                            .foregroundColor(budgetData[2].color)
                    }
                    .font(.caption)
                    .bold()
                }
                .frame(width: 200, height: 200)
                .padding()
            }

            // Simple flow chart mock: Income -> Categories
            VStack(spacing: 10) {
                HStack {
                    Text("Income")
                        .fontWeight(.semibold)
                    Text("→")
                    Text("Needs")
                    Text("(50%)")
                        .foregroundColor(budgetData[0].color)
                }
                HStack {
                    Text(" ")
                    Text(" ")
                    Text("→")
                    Text("Wants")
                    Text("(30%)")
                        .foregroundColor(budgetData[1].color)
                }
                HStack {
                    Text(" ")
                    Text(" ")
                    Text("→")
                    Text("Savings")
                    Text("(20%)")
                        .foregroundColor(budgetData[2].color)
                }
            }
            .font(.headline)
            .padding()

            // TODO: Replace mock data with API fetched budget breakdown data
        }
        .padding()
    }
}

#Preview {
    BudgetView()
}
