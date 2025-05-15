import Foundation

struct UserPreferences: Codable {
    let language: String
    let currency: String
    let notificationsEnabled: Bool
} 