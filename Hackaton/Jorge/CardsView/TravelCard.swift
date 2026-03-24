import Foundation

struct TravelCard: Codable, Identifiable, Hashable
{
    let title: String
    let subtitle: String
    let imageName: String

    var id: String { title + imageName }
}
