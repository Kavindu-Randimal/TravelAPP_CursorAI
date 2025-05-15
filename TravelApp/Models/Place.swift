import Foundation
import CoreLocation

struct Place: Identifiable, Codable {
    let id: String
    var name: String
    var type: PlaceType
    var description: String
    var address: String
    var coordinates: CLLocationCoordinate2D
    var rating: Double
    var priceLevel: Int
    var images: [String]
    var openingHours: [OpeningHours]
    var reviews: [Review]
    var amenities: [String]
    
    enum PlaceType: String, Codable {
        case hotel
        case restaurant
        case attraction
        case nightclub
        case beach
        case shopping
        case museum
    }
    
    struct OpeningHours: Codable {
        var day: Int // 1-7 for Monday-Sunday
        var openTime: String
        var closeTime: String
    }
    
    struct Review: Identifiable, Codable {
        let id: String
        var userId: String
        var userName: String
        var rating: Double
        var comment: String
        var date: Date
    }
}

// Extension to handle CLLocationCoordinate2D encoding/decoding
extension CLLocationCoordinate2D: Codable {
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        self.init(latitude: latitude, longitude: longitude)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
} 