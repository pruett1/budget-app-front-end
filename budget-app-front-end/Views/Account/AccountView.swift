//
//  AccountView.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/29/26.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    @State private var name: String = ""
    @State private var email: String = ""
    @AppStorage("appearance") private var appearance: String = "System"
    
    private let appearanceOptions = ["System", "Light", "Dark"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Button("Connect Accounts (Plaid)") {
                        // TODO: Connect accounts via Plaid
                    }
                }
                
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                    Button("Save") {
                        // TODO: Save updated personal information
                    }
                }
                
                Section(header: Text("Appearance")) {
                    Picker("Appearance", selection: $appearance) {
                        ForEach(appearanceOptions, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Button("Log Out") {
                        sessionManager.logout()
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Account")
        }
    }
}

#Preview {
    AccountView()
        .environmentObject(SessionManager())
}
