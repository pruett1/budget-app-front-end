import SwiftUI

struct Theme {
    static let lightPrimary = Color(red: 255/255, green: 255/255, blue: 255/255)
    static let lightAccent = Color(red: 133/255, green: 187/255, blue: 101/255)
    
    static let darkPrimary = Color(red: 27/255, green: 33/255, blue: 26/255)
    static let darkAccent = Color(red: 16/255, green: 90/255, blue: 55/255)
    
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
}

extension View {
    func appAccentBackground() -> some View {
        self.background(
            EnvironmentReader { scheme in
                Theme.background(for: scheme)
            }
        )
    }
    
    func appAccentForeground() -> some View {
        self.foregroundColor(
            EnvironmentReader { scheme in
                Theme.accent(for: scheme)
            }
        )
    }
}

private struct EnvironmentReader<Content: View>: View {
    @Environment(\.colorScheme) private var colorScheme
    let content: (ColorScheme) -> Content
    
    var body: some View {
        content(colorScheme)
    }
}
