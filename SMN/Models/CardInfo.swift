//
//  CardInfo.swift
//  SMN
//
//  Created by Gil Avalos on 23/03/26.
//

import Foundation
import SwiftUI

struct CardInfo: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let image: String
    let color: Color
}


