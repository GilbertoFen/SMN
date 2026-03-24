//
//  StatDataSource.swift
//  Hackaton
//
//  Created by Annete Morado on 24/03/26.
//

// StatModel.swift
import Foundation
import FirebaseFirestore

struct StatModel: Identifiable, Decodable {
    @DocumentID var id: String?
    let emotion: String
    let date: String
    let id_user: String
    let rating: Int
}

final class StatDataSource {
    private let database = Firestore.firestore()
    private let collection = "stats"

    func getStatsByUser(userId: String, completion: @escaping (Result<[StatModel], Error>) -> Void) {
        database.collection(collection)
            .whereField("id_user", isEqualTo: userId)
            .addSnapshotListener { query, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let documents = query?.documents else {
                    completion(.success([]))
                    return
                }
                let stats = documents.compactMap { try? $0.data(as: StatModel.self) }
                completion(.success(stats))
            }
    }
}
