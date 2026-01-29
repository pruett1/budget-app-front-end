//
//  CreateAccountView.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/29/26.
//

import SwiftUI

struct CreateAccountView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""
    @State private var isCreating = false
    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Email")) {
                    TextField("Enter your email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }

                Section(header: Text("Password")) {
                    SecureField("Enter password", text: $password)
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
                                .frame(maxWidth: .infinity, alignment: .center)
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
