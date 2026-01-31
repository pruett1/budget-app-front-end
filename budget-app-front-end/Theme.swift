import SwiftUI

struct Theme {
    // App Colors
    // Light theme
    static let lightBackground = Color(red: 255/255, green: 255/255, blue: 255/255)
    static let lightPrimary = Color(red: 133/255, green: 187/255, blue: 101/255)
    static let lightSecondary = Color(red: 100/255, green: 150/255, blue: 200/255)
    static let lightFormBackground = Color(red: 245/255, green: 247/255, blue: 244/255)
    static let lightWarning = Color(red: 227/255, green: 176/255, blue: 74/255)
    static let lightError = Color(red: 220/255, green: 70/255, blue: 70/255)
    
    // Dark theme
    static let darkBackground = Color(red: 27/255, green: 33/255, blue: 26/255)
    static let darkPrimary = Color(red: 16/255, green: 90/255, blue: 55/255)
    static let darkSecondary = Color(red: 60/255, green: 120/255, blue: 180/255)
    static let darkFormBackground = Color(red: 38/255, green: 44/255, blue: 44/255)
    static let darkWarning = Color(red: 191/255, green: 143/255, blue: 46/255)
    static let darkError = Color(red: 230/255, green: 100/255, blue: 100/255)
    
    // Theme getters
    static func background(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .dark:
            return darkBackground
        default:
            return lightBackground
        }
    }
    
    static func primary(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .dark:
            return darkPrimary
        default:
            return lightPrimary
        }
    }
    
    static func secondary(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .dark:
            return darkSecondary
        default:
            return lightSecondary
        }
    }
    
    static func formBackground(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .dark:
            return darkFormBackground
        default:
            return lightFormBackground
        }
    }
    
    static func warning(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .dark:
            return darkWarning
        default:
            return lightWarning
        }
    }
    
    static func error(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .dark:
            return darkError
        default:
            return lightError
        }
    }
    
    // Budget Colors
    // Light Theme
    static let lightNeeds = Color(red: 100/255, green: 180/255, blue: 120/255)
    static let lightWants = Color(red: 230/255, green: 150/255, blue: 80/255)
    static let lightSavings = Color(red: 100/255, green: 150/255, blue: 220/255)
    
    // Dark Theme
    static let darkNeeds = Color(red: 16/255, green: 80/255, blue: 45/255)
    static let darkWants = Color(red: 180/255, green: 100/255, blue: 50/255)
    static let darkSavings = Color(red: 60/255, green: 120/255, blue: 180/255)
    
    // Budget getters
    static func needs(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .dark:
            return darkNeeds
        default:
            return lightNeeds
        }
    }
    
    static func wants(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .dark:
            return darkWants
        default:
            return lightWants
        }
    }
    
    static func savings(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .dark:
            return darkSavings
        default:
            return lightSavings
        }
    }
}
