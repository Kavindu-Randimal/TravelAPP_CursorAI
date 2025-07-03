import Foundation

struct ChatMessage: Identifiable, Codable {
    let id: String
    let senderId: String
    let text: String
    let timestamp: Date
}
