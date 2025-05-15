import Foundation

struct Trip: Identifiable, Codable {
    let id: String
    var name: String
    var startDate: Date
    var endDate: Date
    var destination: String
    var budget: Double
    var accommodations: [Accommodation]
    var activities: [Activity]
    var transportation: [Transportation]
    var status: TripStatus
    
    enum TripStatus: String, Codable {
        case planning
        case ongoing
        case completed
        case cancelled
    }
}

struct Accommodation: Identifiable, Codable {
    let id: String
    var name: String
    var type: String
    var address: String
    var checkIn: Date
    var checkOut: Date
    var price: Double
    var rating: Double
    var images: [String]
}

struct Activity: Identifiable, Codable {
    let id: String
    var name: String
    var type: ActivityType
    var description: String
    var location: String
    var price: Double
    var date: Date
    var duration: TimeInterval
    
    enum ActivityType: String, Codable {
        case sightseeing
        case nightlife
        case adventure
        case cultural
        case food
    }
}

struct Transportation: Identifiable, Codable {
    let id: String
    var type: TransportationType
    var provider: String
    var departureTime: Date
    var arrivalTime: Date
    var price: Double
    var status: TransportationStatus
    
    enum TransportationType: String, Codable {
        case flight
        case train
        case bus
        case car
        case boat
    }
    
    enum TransportationStatus: String, Codable {
        case booked
        case confirmed
        case completed
        case cancelled
    }
} 