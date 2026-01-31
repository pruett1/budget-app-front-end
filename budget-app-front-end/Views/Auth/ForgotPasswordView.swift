//
//  ForgotPasswordView.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/29/26.
//


import SwiftUI

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var showConfirmationAlert = false
    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    var body: some View {
        VStack(spacing: 20) {
            Text("Forgot Password")
                .font(.largeTitle)
                .bold()

            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Theme.secondary(for: colorScheme))
                .cornerRadius(8)

            Button("Send Reset Link") {
                // TODO: Implement API call to send reset link
                showConfirmationAlert = true
            }
            .disabled(email.isEmpty)
            .padding()
            .frame(maxWidth: .infinity)
            .background(email.isEmpty ? Color.gray : Theme.primary(for: colorScheme))
            .foregroundColor(.white)
            .cornerRadius(8)

            Spacer()
        }
        .padding()
        .alert(isPresented: $showConfirmationAlert) {
            Alert(
                title: Text("Reset Link Sent"),
                message: Text("If an account with that email exists, a reset link has been sent."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    ForgotPasswordView()
}
