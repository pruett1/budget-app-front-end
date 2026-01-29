//
//  LoginView.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/29/26.
//


import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isLoggingIn = false
    @State private var loginFailed = false

    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                Text("Log In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .background(Theme.background(for: colorScheme))
                    .padding(.bottom, 30)
                
                TextField("Username", text: $username)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Theme.secondary(for: colorScheme))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Theme.background(for: colorScheme).opacity(0.5), lineWidth: 1)
                    )
                
                SecureInputView("Password", text: $password)
                    .padding()
                    .background(Theme.secondary(for: colorScheme))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Theme.background(for: colorScheme).opacity(0.5), lineWidth: 1)
                    )
                
                if loginFailed {
                    Text("Invalid Username or Password")
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                
                Button {
                    isLoggingIn = true
                    loginFailed = false
                    
                    // TODO: Replace with actual API call
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        if !username.isEmpty && !password.isEmpty {
                            Task {
                                await sessionManager.login(
                                    username: username,
                                    password: password
                                )
                            }
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
                            .background(Theme.accent(for: colorScheme))
                            .cornerRadius(8)
                    } else {
                        Text("Log In")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Theme.accent(for: colorScheme))
                            .cornerRadius(8)
                    }
                }
                .disabled(isLoggingIn || username.isEmpty || password.isEmpty)
                
                HStack {
                    Spacer()
                    NavigationLink {
                        ForgotPasswordView()
                    }
                    label: {
                        Text("Forgot Password?")
                            .foregroundColor(Theme.accent(for: colorScheme))
                    }
                    .padding(.top, 10)
                    .padding(.trailing, 10)
                     
                    
                    NavigationLink {
                        CreateAccountView()
                    }
                    label: {
                       Text("Register")
                            .foregroundColor(Theme.accent(for: colorScheme))
                    }
                    .padding(.top, 10)
                    .padding(.leading, 10)
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding()
            .background(
                Theme.background(for: colorScheme)
                    .ignoresSafeArea()
            )
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(SessionManager())
    }
}
