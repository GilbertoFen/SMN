
import Foundation


struct Item: Identifiable, Equatable
{
    let id = UUID()
    let text: String
    let isFromUser: Bool
    var isTyping: Bool = false
}
