// Helpers.swift
import Foundation

func formatDateString(stringDate: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"
    let outputFormatter = DateFormatter()
    outputFormatter.locale = Locale(identifier: "es_MX")
    outputFormatter.dateFormat = "d 'de' MMMM, yyyy"
    if let date = inputFormatter.date(from: stringDate) {
        return outputFormatter.string(from: date)
    }
    return stringDate
}
