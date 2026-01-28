//
//  budget_app_front_endApp.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/28/26.
//

import SwiftUI
import SwiftData

@main
struct budget_app_front_endApp: App {
    @StateObject private var sessionManager = SessionManager()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @AppStorage("appearance") private var appearance: String = "system"
    
    private var preferredColorScheme: ColorScheme? {
        switch appearance {
        case "light": return .light
        case "dark": return .dark
        default: return nil
        }
    }

    var body: some Scene {
        WindowGroup {
            if sessionManager.isAuthenticated {
                NavigationStack {
                    MainTabView()
                        .environmentObject(sessionManager)
                }
            } else {
                NavigationStack {
                    LandingView()
                        .environmentObject(sessionManager)
                }
            }
        }
        .onAppear {
            sessionManager.restore()
        }
        .environment(\.colorScheme, preferredColorScheme)
        .modelContainer(sharedModelContainer)
    }
}
