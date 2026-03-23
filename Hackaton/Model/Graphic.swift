//
//  Graphic.swift
//  Hackaton
//
//  Created by Annete Morado on 23/03/26.
//

import Foundation

struct Graphic: Hashable, Identifiable, Codable{
    var id: Int
    var date: String
    var score: Int
    var emotion: String
    
    init(id: Int, date: String, score: Int, emotion: String) {
        self.id = id
        self.date = String(date.split(separator: "-")[2])
        self.score = score
        self.emotion = emotion
    }
}
