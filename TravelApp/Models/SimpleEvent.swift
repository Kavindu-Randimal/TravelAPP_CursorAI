import Foundation

struct SimpleEvent: Identifiable, Codable {
    let id: String
    let title: String
    let date: Date
}
