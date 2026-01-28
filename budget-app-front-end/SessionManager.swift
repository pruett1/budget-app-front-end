import SwiftUI
import Foundation

@MainActor
class SessionManager: ObservableObject {
    @Published private(set) var sessionToken: String? {
        didSet {
            if let token = sessionToken {
                UserDefaults.standard.set(token, forKey: Self.tokenKey)
            } else {
                UserDefaults.standard.removeObject(forKey: Self.tokenKey)
            }
        }
    }
    
    static private let tokenKey = "sessionToken"
    
    var isAuthenticated: Bool {
        sessionToken != nil
    }
    
    func login(username: String, password: String) async {
        // TODO: Perform API call to login with username and password
        // Mock implementation:
        await Task.sleep(500_000_000) // Simulate network delay
        sessionToken = UUID().uuidString
    }
    
    func createAccount(email: String, password: String) async {
        // TODO: Perform API call to create account with email and password
        // Mock implementation:
        await Task.sleep(500_000_000) // Simulate network delay
        sessionToken = UUID().uuidString
    }
    
    func logout() {
        sessionToken = nil
    }
    
    func restore() {
        if let token = UserDefaults.standard.string(forKey: Self.tokenKey) {
            sessionToken = token
        }
    }
}
