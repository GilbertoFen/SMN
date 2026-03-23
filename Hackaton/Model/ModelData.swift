//
//  ModelData.swift
//  Hackaton
//
//  Created by Annete Morado on 23/03/26.
//

import Foundation

@Observable
class ModelData{
    var psycologists: [Psycologist] = load("psycologistData.json")
    
    var appointments: [Appointment] = load("appointmentData.json")
    
    var issues: [Issue] = load("issuesData.json")
    
    var graphics: [Graphic] = load("graphicsData.json")
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data


    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }


    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }


    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

