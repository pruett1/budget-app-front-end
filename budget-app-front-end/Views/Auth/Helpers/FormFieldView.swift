//
//  FormFieldView.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/29/26.
//

import SwiftUI

struct FormFieldView: View {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @Binding private var text: String
    
    private var placeholder: String
    private var title: String
    private var keyboardType: UIKeyboardType
    
    
    init(_ title: String, text: Binding<String>, placeholder: String = "", keyboardType: UIKeyboardType = .default) {
        self.title = title
        self._text = text
        self.placeholder = !placeholder.isEmpty ? placeholder : title
        self.keyboardType = keyboardType
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
            
            TextField("", text: $text, prompt: Text(verbatim: placeholder))
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(Theme.secondary(for: colorScheme))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Theme.background(for: colorScheme).opacity(0.5), lineWidth: 1)
                )
                .keyboardType(keyboardType)
        }
    }
}
