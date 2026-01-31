//
//  AccountView.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/29/26.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    @State private var name: String = ""
    @State private var email: String = ""
    @AppStorage("appearance") private var appearance: String = "System"
    
    private let appearanceOptions = ["System", "Light", "Dark"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                Button {
                    // TODO: Connect accounts via Plaid
                } label: {
                    Text("Connect Account to Plaid")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(Theme.accent(for: colorScheme))
                        .cornerRadius(8)
                }
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Personal Info:")
                        .foregroundColor(Theme.accent(for: colorScheme))
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                }
                
                VStack(spacing: 10) {
                    Text("Theme")
                        .foregroundColor(Theme.accent(for: colorScheme))
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                    Picker("", selection: $appearance) {
                        ForEach(appearanceOptions, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Spacer()
                
                Button {
                    sessionManager.logout()
                } label: {
                    Text("Logout")
                        .foregroundColor(Theme.tertiary(for: colorScheme))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(Theme.secondary(for: colorScheme))
                        .cornerRadius(8)
                }
            }
            .padding()
            .background(Theme.background(for: colorScheme))
        }
    }
}

#Preview {
    AccountView()
        .environmentObject(SessionManager())
}
