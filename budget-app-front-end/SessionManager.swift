import SwiftUI
import Foundation
import Combine

@MainActor
class SessionManager: ObservableObject {
    
    @Published private(set) var sessionToken: String? {
        didSet {
            if let token = sessionToken {
                UserDefaults.standard.set(token, forKey: Self.tokenKey)
            }
            else {
                UserDefaults.standard.removeObject(forKey: Self.tokenKey)
            }
        }
    }
    
    @Published private(set) var sessionIssue: Date? {
        didSet {
            if let issue = sessionIssue {
                UserDefaults.standard.set(issue, forKey: Self.issueKey)
            }
            else {
                UserDefaults.standard.removeObject(forKey: Self.issueKey)
            }
        }
    }
 
    static private let tokenKey = "sessionToken"
    static private let issueKey = "sessionIssue"
    
    var hasValidToken: Bool {
        guard let issue = sessionIssue else {return false}
        return Date().timeIntervalSince(issue) < 3600
    }
    
    var isAuthenticated: Bool {
        sessionToken != nil && hasValidToken
    }
    
    func login(username: String, password: String) async {
        // TODO: Perform API call to login with username and password
        // Mock implementation:
//        await Task.sleep(nanoseconds: 500_000_000) // Simulate network delay
        sessionToken = UUID().uuidString
        sessionIssue = Date()
    }
    
    func createAccount(email: String, password: String) async {
        // TODO: Perform API call to create account with email and password
        // Mock implementation:
//        await Task.sleep(nanoseconds: 500_000_000) // Simulate network delay
        sessionToken = UUID().uuidString
        sessionIssue = Date()
    }
    
    /// Sets the current session token in a controlled way
    func setSessionToken(_ token: String?) {
        self.sessionToken = token
    }
    
    func logout() {
        sessionToken = nil
        sessionIssue = nil
    }
    
    func restore() {
        sessionToken = UserDefaults.standard.string(forKey: Self.tokenKey)
        sessionIssue = UserDefaults.standard.object(forKey: Self.issueKey) as? Date
    }
}
