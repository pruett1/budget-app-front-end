import SwiftUI

struct Theme {
    static let lightPrimary = Color(red: 255/255, green: 255/255, blue: 255/255)
    static let lightAccent = Color(red: 133/255, green: 187/255, blue: 101/255)
    static let lightSecondary = Color(red: 245/255, green: 247/255, blue: 244/255)
    static let lightTertiary = Color(red: 227/255, green: 176/255, blue: 74/255)
    
    static let darkPrimary = Color(red: 27/255, green: 33/255, blue: 26/255)
    static let darkAccent = Color(red: 16/255, green: 90/255, blue: 55/255)
    static let darkSecondary = Color(red: 38/255, green: 44/255, blue: 44/255)
    static let darkTertiary = Color(red: 191/255, green: 143/255, blue: 46/255)
    
    static func background(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .dark:
            return darkPrimary
        default:
            return lightPrimary
        }
    }
    
    static func accent(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .dark:
            return darkAccent
        default:
            return lightAccent
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
    
    static func tertiary(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .dark:
            return darkTertiary
        default:
            return lightTertiary
        }
    }
}

extension View {
    func appAccentBackground() -> some View {
        modifier(AppAccentBackgroundModifier())
    }
    
    func appAccentForeground() -> some View {
        modifier(AppAccentForegroundModifier())
    }
}

private struct AppAccentBackgroundModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    func body(content: Content) -> some View {
        content.background(Theme.background(for: colorScheme))
    }
}

private struct AppAccentForegroundModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    func body(content: Content) -> some View {
        content.foregroundColor(Theme.accent(for: colorScheme))
    }
}
