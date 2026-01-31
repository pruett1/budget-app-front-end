//
//  CreateAccountView.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/29/26.
//

import SwiftUI

struct CreateAccountView: View {
    @State private var username = ""
    @State private var firstName = ""
    @State private var lastName = ""
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
        VStack(spacing: 10) {
            ZStack(alignment: .top) {
                Theme.primary(for: colorScheme)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Text("Create Account")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            .frame(height: 10)
            
            
            
            ScrollView {
                VStack(spacing: 20) {
                    // Username Field
                    FormFieldView("Username", text: $username)
                    
                    // Name Field
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Name")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        TextField("First Name", text: $firstName)
                            .autocapitalization(.words)
                            .disableAutocorrection(true)
                            .padding()
                            .background(Theme.formBackground(for: colorScheme))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Theme.background(for: colorScheme).opacity(0.5), lineWidth: 1)
                            )
                        
                        TextField("Last Name", text: $lastName)
                            .autocapitalization(.words)
                            .disableAutocorrection(true)
                            .padding()
                            .background(Theme.formBackground(for: colorScheme))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Theme.background(for: colorScheme).opacity(0.5), lineWidth: 1)
                            )
                    }
                    
                    // Email Field
                    FormFieldView("Email", text: $email, placeholder: "example@example.com")
                    
                    // Phone Field
                    FormFieldView("Phone", text: PhoneFormatter.binding($phoneNumber), placeholder: "(XXX) XXX-XXXX", keyboardType: .phonePad)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Password")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        SecureInputView("Password", text: $password)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding()
                            .background(Theme.formBackground(for: colorScheme))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Theme.background(for: colorScheme).opacity(0.5), lineWidth: 1)
                            )
                        
                        SecureField("Confirm Password", text: $confirmPassword)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding()
                            .background(Theme.formBackground(for: colorScheme))
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
                                .background(Theme.primary(for: colorScheme))
                                .cornerRadius(8)
                        }
                    }
                    .disabled(isCreating || firstName.isEmpty || lastName.isEmpty || password.isEmpty || confirmPassword.isEmpty)
                    
                }
                .padding()
            }
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
