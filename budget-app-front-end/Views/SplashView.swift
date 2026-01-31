//
//  SplashView.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/29/26.
//
import SwiftUI

struct SplashView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        VStack {
            Image(systemName: "dollarsign.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(Theme.primary(for: colorScheme))
                .padding(.bottom, 50)
            
            
            
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle(tint: Theme.primary(for: colorScheme)))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Theme.background(for: colorScheme))
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
