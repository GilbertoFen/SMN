//
//  Appointment.swift
//  Hackaton
//
//  Created by Annete Morado on 23/03/26.
//

import Foundation

struct Appointment: Codable, Identifiable, Hashable{
    var id: Int
    var id_psycologist: String
    var hour: String
    var date: String
}
