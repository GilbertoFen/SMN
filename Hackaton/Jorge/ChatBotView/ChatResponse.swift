import Foundation

struct ChatResponse: Codable
{
    let reply: String?
    let error: String?
    let details: String?

    let action: String?
    let destination: String?
    let cards: [TravelCard]?
}
