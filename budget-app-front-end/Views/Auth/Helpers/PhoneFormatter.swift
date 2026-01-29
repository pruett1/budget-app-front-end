//
//  PhoneFormatter.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/29/26.
//

import SwiftUI

struct PhoneFormatter {
    static func binding(_ binding: Binding<String>) -> Binding<String> {
        Binding<String>(
            get: {
                binding.wrappedValue
            },
            set: { newValue in
                let digits = newValue.filter{"0123456789".contains($0)}
                
                var formatted = ""
                let count = digits.count
                
                if count > 0 {
                    formatted += "("
                    formatted += digits.prefix(3)
                }
                
                if count > 3 {
                    formatted += ") "
                    let start = digits.index(digits.startIndex, offsetBy: 3)
                    let end = digits.index(start, offsetBy: min(3, count - 3))
                    formatted += digits[start..<end]
                }
                
                if count > 6 {
                    formatted += "-"
                    let start = digits.index(digits.startIndex, offsetBy: 6)
                    let end = digits.index(start, offsetBy: min(4, count - 6))
                    formatted += digits[start..<end]
                }
                
                binding.wrappedValue = formatted
            }
        )
    }
}
