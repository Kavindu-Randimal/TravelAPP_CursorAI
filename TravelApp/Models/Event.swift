import Foundation

struct Event: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let date: Date
    let startTime: Date
    let endTime: Date
    let price: Double
    let ticketAvailability: Int
    let images: [String]
    let venue: Venue
    let performers: [String]
    let category: EventCategory
}

struct Venue {
    let name: String
    let address: String
}

enum EventCategory: String, CaseIterable {
    case music = "Music"
    case sports = "Sports"
    case arts = "Arts"
    case food = "Food"
    case nightlife = "Nightlife"
} 