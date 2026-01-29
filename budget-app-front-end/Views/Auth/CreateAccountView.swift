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
        NavigationView {
            Form {
                Section(header: Text("Username")) {
                    TextField("Username", text: $username)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                }
                
                Section(header: Text("Email")) {
                    TextField("", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
//                        .onSubmit {
//                            let valid  = Validation.isValidEmail(email)
//                            Alert(title: "Invalid Email")
//                        }
                }
                
                Section(header: Text("Phone Number")) {
                    TextField("", text: PhoneFormatter.binding($phoneNumber))
                        .keyboardType(.phonePad)
                        .autocapitalization(.none)
                }

                Section(header: Text("Password")) {
                    SecureInputView("Enter password", text: $password)
                    SecureField("Confirm password", text: $confirmPassword)
                }

                if !errorMessage.isEmpty {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }

                Section {
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
                
            }
            .navigationTitle("Create Account")
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
