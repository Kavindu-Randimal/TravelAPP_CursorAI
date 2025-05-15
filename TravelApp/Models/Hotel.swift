import Foundation

struct Hotel: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let stars: Int
    let price: Int

    static let sampleHotels: [Hotel] = [
        Hotel(name: "Hotel Diplomat Stockholm", imageName: "hotel1", stars: 5, price: 7800),
        Hotel(name: "Hotel Diplomat Stockholm", imageName: "hotel1", stars: 5, price: 7800),
        Hotel(name: "Hotel Diplomat Stockholm", imageName: "hotel1", stars: 5, price: 7800)
    ]
} 