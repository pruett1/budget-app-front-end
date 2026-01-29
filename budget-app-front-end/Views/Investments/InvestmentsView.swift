//
//  InvestmentsView.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/29/26.
//


import SwiftUI
import Charts

struct InvestmentsView: View {
    enum TimeRange: String, CaseIterable, Identifiable {
        case oneMonth = "1M"
        case sixMonths = "6M"
        case ytd = "YTD"
        case oneYear = "1Y"
        case all = "All"
        
        var id: String { rawValue }
    }
    
    @State private var selectedTimeRange: TimeRange = .oneMonth
    
    // Mock total investment value for demonstration
    @State private var totalInvestmentValue: Double = 125_764.32
    
    // Mock data for Portfolio and S&P 500 (same dates, different values)
    struct InvestmentDataPoint: Identifiable {
        let id = UUID()
        let date: Date
        let portfolioValue: Double
        let sp500Value: Double
    }
    
    // Generate mock data based on selected time range
    private var chartData: [InvestmentDataPoint] {
        let calendar = Calendar.current
        let today = Date()
        var daysCount: Int
        
        switch selectedTimeRange {
        case .oneMonth:
            daysCount = 30
        case .sixMonths:
            daysCount = 180
        case .ytd:
            let startOfYear = calendar.date(from: calendar.dateComponents([.year], from: today))!
            daysCount = calendar.dateComponents([.day], from: startOfYear, to: today).day ?? 0
        case .oneYear:
            daysCount = 365
        case .all:
            daysCount = 730 // 2 years for example
        }
        
        var data: [InvestmentDataPoint] = []
        for i in 0..<daysCount {
            guard let date = calendar.date(byAdding: .day, value: -i, to: today) else { continue }
            // Simple mock values with some variation
            let portfolioValue = 100_000 + Double(i) * 50 + Double.random(in: -500...500)
            let sp500Value = 120_000 + Double(i) * 45 + Double.random(in: -400...400)
            data.append(InvestmentDataPoint(date: date, portfolioValue: portfolioValue, sp500Value: sp500Value))
        }
        return data.sorted { $0.date < $1.date }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total Investments")
                        .font(.headline)
                    Text(totalInvestmentValue, format: .currency(code: "USD"))
                        .font(.largeTitle.bold())
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                Picker("Time Range", selection: $selectedTimeRange) {
                    ForEach(TimeRange.allCases) { range in
                        Text(range.rawValue).tag(range)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                // Chart placeholder with Swift Charts
                if #available(iOS 16.0, *) {
                    Chart {
                        ForEach(chartData) { point in
                            LineMark(
                                x: .value("Date", point.date),
                                y: .value("Portfolio", point.portfolioValue)
                            )
                            .foregroundStyle(Color.blue)
                            .interpolationMethod(.catmullRom)
                            
                            LineMark(
                                x: .value("Date", point.date),
                                y: .value("S&P 500", point.sp500Value)
                            )
                            .foregroundStyle(Color.red)
                            .interpolationMethod(.catmullRom)
                        }
                    }
                    .chartXAxis {
                        AxisMarks(values: .stride(by: .month)) { _ in
                            AxisGridLine()
                            AxisTick()
                            AxisValueLabel(format: .dateTime.month(.abbreviated))
                        }
                    }
                    .frame(height: 220)
                    .padding(.horizontal)
                } else {
                    // Fallback: simple Path line chart
                    GeometryReader { geo in
                        ZStack {
                            // Axes lines
                            Path { path in
                                path.move(to: CGPoint(x: 40, y: geo.size.height - 30))
                                path.addLine(to: CGPoint(x: geo.size.width - 10, y: geo.size.height - 30))
                                path.move(to: CGPoint(x: 40, y: geo.size.height - 30))
                                path.addLine(to: CGPoint(x: 40, y: 10))
                            }
                            .stroke(Color.secondary, lineWidth: 1)
                            
                            // Portfolio path
                            Path { path in
                                let points = chartData
                                guard points.count > 1 else { return }
                                let maxVal = (points.map { max($0.portfolioValue, $0.sp500Value) }.max() ?? 1)
                                let minVal = (points.map { min($0.portfolioValue, $0.sp500Value) }.min() ?? 0)
                                let xStep = (geo.size.width - 50) / CGFloat(points.count - 1)
                                for (index, point) in points.enumerated() {
                                    let x = 40 + CGFloat(index) * xStep
                                    let y = geo.size.height - 30 - CGFloat((point.portfolioValue - minVal) / (maxVal - minVal)) * (geo.size.height - 40)
                                    if index == 0 {
                                        path.move(to: CGPoint(x: x, y: y))
                                    } else {
                                        path.addLine(to: CGPoint(x: x, y: y))
                                    }
                                }
                            }
                            .stroke(Color.blue, lineWidth: 2)
                            
                            // S&P 500 path
                            Path { path in
                                let points = chartData
                                guard points.count > 1 else { return }
                                let maxVal = (points.map { max($0.portfolioValue, $0.sp500Value) }.max() ?? 1)
                                let minVal = (points.map { min($0.portfolioValue, $0.sp500Value) }.min() ?? 0)
                                let xStep = (geo.size.width - 50) / CGFloat(points.count - 1)
                                for (index, point) in points.enumerated() {
                                    let x = 40 + CGFloat(index) * xStep
                                    let y = geo.size.height - 30 - CGFloat((point.sp500Value - minVal) / (maxVal - minVal)) * (geo.size.height - 40)
                                    if index == 0 {
                                        path.move(to: CGPoint(x: x, y: y))
                                    } else {
                                        path.addLine(to: CGPoint(x: x, y: y))
                                    }
                                }
                            }
                            .stroke(Color.red, lineWidth: 2)
                        }
                    }
                    .frame(height: 220)
                    .padding(.horizontal)
                }
                
                NavigationLink {
                    InvestmentsBreakdownView()
                } label: {
                    Text("Tap to expand breakdown by account")
                        .fontWeight(.medium)
                        .foregroundColor(.blue)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .navigationTitle("Investments")
            // TODO: Replace mock data with API-driven real investment data
        }
    }
}

struct InvestmentsBreakdownView: View {
    // Mock accounts and balances
    struct Account: Identifiable {
        let id = UUID()
        let name: String
        let balance: Double
    }
    
    let accounts: [Account] = [
        Account(name: "401(k)", balance: 54000),
        Account(name: "Brokerage", balance: 40000),
        Account(name: "Roth IRA", balance: 31764.32),
        Account(name: "HSA", balance: 2000)
    ]
    
    var body: some View {
        List {
            ForEach(accounts) { account in
                HStack {
                    Text(account.name)
                    Spacer()
                    Text(account.balance, format: .currency(code: "USD"))
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("Investments Breakdown")
        // TODO: Replace mock accounts with API-driven account breakdown
    }
}

struct InvestmentsView_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentsView()
    }
}
