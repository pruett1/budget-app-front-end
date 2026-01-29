//
//  SecureInput.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/29/26.
//
import SwiftUI

struct SecureInputView: View {
    @Binding private var text: String
    @State private var isSecure: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        HStack {
            Group {
                if isSecure {
                    SecureField(title, text: $text)
                }
                else {
                    TextField(title, text: $text)
                }
            }
            
            Button(action: {
                isSecure.toggle()
            }) {
                Image(systemName: isSecure ? "eye.slash" : "eye") .accentColor(.gray)
            }
        }
    }
}
