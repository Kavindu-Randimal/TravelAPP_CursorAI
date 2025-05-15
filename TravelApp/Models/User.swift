import Foundation

struct User: Identifiable, Codable {
    let id: String
    var email: String
    var name: String
    var profileImage: String?
    var preferences: UserPreferences
    var savedTrips: [Trip]
    var favoritePlaces: [Place]
} 