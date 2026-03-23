//
//  Item.swift
//  SMN
//
//  Created by Gil Avalos on 23/03/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
