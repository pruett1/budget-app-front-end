//
//  LoginView.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/29/26.
//


import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggingIn = false
    @State private var loginFailed = false
    @State private var navigateToMain = false
    @State private var navigateToForgotPassword = false

    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Log In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .background(Theme.background(for: colorScheme))
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Theme.accent(for: colorScheme))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Theme.background(for: colorScheme).opacity(0.5), lineWidth: 1)
                    )
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Theme.accent(for: colorScheme))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Theme.background(for: colorScheme).opacity(0.5), lineWidth: 1)
                    )
                
                if loginFailed {
                    Text("Login failed. Please check your credentials.")
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                
                Button {
                    isLoggingIn = true
                    loginFailed = false
                    
                    // TODO: Replace with actual API call
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        if !email.isEmpty && !password.isEmpty {
                            Task {
                                await sessionManager.login(
                                    username: email,
                                    password: password
                                )
                            }
                            navigateToMain = true
                        } else {
                            loginFailed = true
                        }
                        isLoggingIn = false
                    }
                } label: {
                    if isLoggingIn {
                        ProgressView()
                            .progressViewStyle(
                                CircularProgressViewStyle(
                                    tint: Theme.accent(for: colorScheme)
                                )
                            )
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Theme.background(for: colorScheme).opacity(0.2))
                            .cornerRadius(8)
                    } else {
                        Text("Log In")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Theme.background(for: colorScheme))
                            .cornerRadius(8)
                    }
                }
                .disabled(isLoggingIn || email.isEmpty || password.isEmpty)
                
                Button {
                    navigateToForgotPassword = true
                } label: {
                    Text("Forgot Password?")
                        .foregroundColor(Theme.secondary(for: colorScheme))
                }
                .padding(.top, 10)
                
                Spacer()
            }
            .padding()
            .background(
                Theme.background(for: colorScheme)
                    .ignoresSafeArea()
            )
            .navigationDestination(isPresented: $navigateToMain) {
                MainTabView()
                    .environmentObject(sessionManager)
            }
            .navigationDestination(isPresented: $navigateToForgotPassword) {
                ForgotPasswordView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(SessionManager())
    }
}
