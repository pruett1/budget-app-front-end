//
//  AccountView.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/29/26.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var sessionManager: SessionManager
//    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    private var colorScheme: ColorScheme = .dark
    
    @State private var name: String = ""
    @State private var email: String = ""
    @AppStorage("appearance") private var appearance: String = "System"
    
    private let appearanceOptions = ["System", "Light", "Dark"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Personal Info")
                        .foregroundColor(Theme.primary(for: colorScheme))
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack {
                        Text("Name: ")
                            .foregroundColor(Theme.secondary(for: colorScheme))
                        
                        Spacer()
                       
                        // TODO: have this load in from saved val
                        Text("Bob")
                        
                        Text("Smith")

                    }
                    
                    HStack {
                        Text("Email: ")
                            .foregroundColor(Theme.secondary(for: colorScheme))

                        Spacer()
                        
                        Text(verbatim: "bobsmith@gmail.com")
                    }
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Theme")
                        .foregroundColor(Theme.primary(for: colorScheme))
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Picker("Theme", selection: $appearance) {
                        ForEach(appearanceOptions, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding()
                
                Button {
                    // TODO: Connect accounts via Plaid
                } label: {
                    Text("Connect Account to Plaid")
                        .foregroundColor(Theme.primary(for: colorScheme))
                        .background(Theme.background(for: colorScheme))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .cornerRadius(16)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Theme.primary(for: colorScheme), lineWidth: 1)
                        }
                }
                
                Spacer()
                
                Button {
                    sessionManager.logout()
                } label: {
                    Text("Logout")
                        .foregroundColor(Theme.error(for: colorScheme))
                        .background(Theme.background(for: colorScheme))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .cornerRadius(16)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Theme.error(for: colorScheme), lineWidth: 1)
                        }
                        
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
