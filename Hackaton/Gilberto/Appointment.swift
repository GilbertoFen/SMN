//
//  Appointment.swift
//  SMN
//
//  Created by Gil Avalos on 23/03/26.
//

import Foundation
import CoreLocation

struct Appointment : Hashable, Codable, Identifiable{
    var id: Int
    var  hour: String
    var date: String
    var id_psycologist: Int
    var  commentary: String
    var location: String
    var estado: String
    var calificacion: Int
}
