//
//  functions.swift
//  SMN
//
//  Created by Gil Avalos on 23/03/26.
//

import Foundation
import SwiftUI

func formatDateString(stringDate: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"
    
    guard let objectDate = inputFormatter.date(from: stringDate) else {
        return "Formato de fecha inválido"
    }
    
    let StringFormatted = DateFormatter()
    StringFormatted.locale = Locale(identifier: "es_ES")
    StringFormatted.dateFormat = "d 'de' MMMM 'de' yyyy"
    
    return StringFormatted.string(from: objectDate)
}
