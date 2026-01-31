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
    @State private var isLoading: Bool = true
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([Item.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @AppStorage("appearance") private var appearance: String = "System"
    
    private var preferredColorScheme: ColorScheme? {
        switch appearance {
        case "Light": return .light
        case "Dark": return .dark
        default: return nil
        }
    }
    
    func initializeApp() async {
        sessionManager.restore()
        Task.detached(priority: .userInitiated) {
            _ = sharedModelContainer
        }
        isLoading = false
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                if isLoading {
                    SplashView()
                }
                else {
                    Group {
                        if sessionManager.isAuthenticated {
                            NavigationStack {
                                MainTabView()
                                    .environmentObject(sessionManager)
                            }
                            .onAppear {
                                sessionManager.restore()
                            }
                        } else {
                            NavigationStack {
                                LoginView()
                                    .environmentObject(sessionManager)
                            }
                            .onAppear {
                                sessionManager.restore()
                            }
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    await initializeApp()
                }
            }
            .environmentObject(sessionManager)
            .preferredColorScheme(preferredColorScheme)
        }
        .modelContainer(sharedModelContainer)
    }
}
