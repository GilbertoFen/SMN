import SwiftUI

struct tripCard: Identifiable, Hashable
{
    var id: UUID = .init()
    var title: String
    var subtitle: String
    var image: String
}


var tripCards: [tripCard] =
[
    .init(title: "London", subtitle: "England", image: "pic 1"),
    .init(title: "NewYor", subtitle: "USA", image: "pic 2"),
    .init(title: "Parague", subtitle: "Cszh Republic", image: "Pic 3")
]
