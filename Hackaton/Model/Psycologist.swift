//
//  Psycologist.swift
//  Hackaton
//
//  Created by Annete Morado on 23/03/26.
//

import Foundation
import CoreLocation

struct Psycologist: Hashable, Codable, Identifiable{
    var id: Int
    var name: String
    
    private var coordinates: Coordinates
    
    var locationCoordinates: CLLocationCoordinate2D{
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
    
    struct Coordinates: Hashable, Codable{
        var latitude: Double
        var longitude: Double
    }
}
