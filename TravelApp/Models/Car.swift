import Foundation

struct Car: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let imageName: String
    let price: Int

    static let sampleCars: [Car] = [
        Car(name: "Suzuki Alto 2015", type: "XL", imageName: "car1", price: 2000),
        Car(name: "Honda Fit", type: "Premium", imageName: "car2", price: 2500),
        Car(name: "Hyundai Eon", type: "Economy", imageName: "car3", price: 1800)
    ]
} 