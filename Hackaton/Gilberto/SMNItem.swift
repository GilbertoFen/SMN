//
//  Item.swift
//  SMN
//
//  Created by Gil Avalos on 23/03/26.
//

import Foundation
import SwiftData

// Item.swift
@Model
final class SMNItem {
    var timestamp: Date
    init(timestamp: Date) { self.timestamp = timestamp }
}

// SMNApp.swift
let schema = Schema([SMNItem.self])
