//
//  LandingView.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/29/26.
//


import SwiftUI

struct LandingView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Text("App Logo / Title")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Theme.background(for: colorScheme))

                VStack(spacing: 20) {
                    NavigationLink {
                        LoginView()
                    } label: {
                        Text("Log In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Theme.background(for: colorScheme))
                            .cornerRadius(10)
                    }

                    NavigationLink {
                        CreateAccountView()
                    } label: {
                        Text("Create Account")
                            .font(.headline)
                            .foregroundColor(Theme.background(for: colorScheme))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Theme.background(for: colorScheme), lineWidth: 2)
                            )
                    }
                }
                .padding(.horizontal, 30)
            }
            .padding()
        }
    }
}

#Preview {
    LandingView()
}
