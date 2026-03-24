//
//  UserDataSource.swift
//  Hackaton
//
//  Created by Annete Morado on 23/03/26.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreCombineSwift
import CoreLocation

struct PsycologistModel: Decodable, Identifiable, Encodable, Equatable{
    @DocumentID var id: String?
    
    let name: String
    let age: Double
    let latitude: Double
    let longitude: Double
    let mode: [String]
    let price: Double
    let speciality: String
    let rating: Double
    let description: String
    let photoName: String
    
    var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

final class PsychologistDataSource {
    private let database = Firestore.firestore()
    
    private let collection = "psycologists"
    
    func getAllPsycologists(completitionBlock: @escaping (Result<[PsycologistModel], Error>) -> Void){
        database.collection(collection)
            .addSnapshotListener{ query, error in
                if let error = error {
                    completitionBlock(.failure(error))
                    return
                }
                guard let documents = query?.documents.compactMap({ $0 }) else{
                    completitionBlock(.success([]))
                    return
                }
                let psycologists = documents.map{ try? $0.data(as: PsycologistModel.self) }
                    .compactMap({ $0 })
                completitionBlock(.success(psycologists))
            }
    }
    
    
    
    
}
