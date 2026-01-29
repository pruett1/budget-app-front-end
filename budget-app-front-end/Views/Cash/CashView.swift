//
//  CashView.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/29/26.
//


import SwiftUI

struct CashView: View {
    @State private var showBreakdown = false
    
    // TODO: Replace with real API data
    @State private var totalCashValue: Double = 12345.67
    @State private var historicalValues: [Double] = [12000, 12150, 12200, 12300, 12345.67]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Total Cash")
                .font(.headline)
            
            Text("$\(totalCashValue, specifier: "%.2f")")
                .font(.largeTitle)
                .fontWeight(.bold)
                .onTapGesture {
                    showBreakdown.toggle()
                }
            
            // Placeholder line chart for historical cash value
            LineChartView(values: historicalValues)
                .frame(height: 150)
                .padding()
            
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showBreakdown) {
            CashBreakdownView()
        }
    }
}

struct CashBreakdownView: View {
    // TODO: Replace with real API data for breakdown
    let breakdownItems = [
        ("Checking Account", 5000.00),
        ("Savings Account", 7000.00),
        ("Cash on Hand", 1345.67)
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(breakdownItems, id: \.0) { item in
                    HStack {
                        Text(item.0)
                        Spacer()
                        Text("$\(item.1, specifier: "%.2f")")
                    }
                }
            }
            .navigationTitle("Cash Breakdown")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        // Dismiss Sheet
                        // The parent view handles dismissal
                    }
                }
            }
        }
    }
}

struct LineChartView: View {
    var values: [Double]
    
    var body: some View {
        GeometryReader { geometry in
            let maxValue = values.max() ?? 1
            let minValue = values.min() ?? 0
            let range = maxValue - minValue == 0 ? 1 : maxValue - minValue
            
            let width = geometry.size.width
            let height = geometry.size.height
            let step = width / CGFloat(values.count - 1)
            
            Path { path in
                for index in values.indices {
                    let x = step * CGFloat(index)
                    let y = height * (1 - CGFloat((values[index] - minValue) / range))
                    if index == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
            }
            .stroke(Color.blue, lineWidth: 2)
        }
    }
}

#Preview {
    CashView()
}
