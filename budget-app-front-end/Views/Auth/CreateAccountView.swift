//
//  CreateAccountView.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/29/26.
//

import SwiftUI

struct CreateAccountView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""
    @State private var isCreating = false
    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Create Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                    .foregroundColor(Theme.accent(for: colorScheme))
                
                // Username Field
                FormFieldView("Username", text: $username)
                
                // Email Field
                FormFieldView("Email", text: $email, placeholder: "example@example.com")
                
                // Phone Field
                FormFieldView("Phone", text: PhoneFormatter.binding($phoneNumber), placeholder: "(XXX) XXX-XXXX", keyboardType: .phonePad)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Password")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    SecureInputView("Password", text: $password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Theme.secondary(for: colorScheme))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Theme.background(for: colorScheme).opacity(0.5), lineWidth: 1)
                        )
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Theme.secondary(for: colorScheme))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Theme.background(for: colorScheme).opacity(0.5), lineWidth: 1)
                        )
                }

                
                Button {
                    Task { await createAccount() }
                } label: {
                    if isCreating {
                        ProgressView()
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        Text("Create Account")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .background(Theme.accent(for: colorScheme))
                            .cornerRadius(8)
                    }
                }
                .disabled(isCreating || email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
                
            }
            .padding()
        }
    }

    private func createAccount() async {
        errorMessage = ""
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }

        isCreating = true

        do {
            // Perform create account API call
            await sessionManager.createAccount(email: email, password: password)
            // On success, dismiss
            isCreating = false
            dismiss()
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
            .environmentObject(SessionManager())
    }
}
