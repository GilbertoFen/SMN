//
//  CommentDataSource.swift
//  Hackaton
//
//  Created by Annete Morado on 24/03/26.
//

import Foundation
import FirebaseFirestore

struct CommentModel: Identifiable, Decodable, Encodable {
    @DocumentID var id: String?
    let comment: String
    let id_psycologist: String
    let id_user: String
    let rating: Int
}

final class CommentDataSource {
    private let database = Firestore.firestore()
    private let collection = "comments"

    func getCommentsByPsycologist(psycologistId: String, completion: @escaping (Result<[CommentModel], Error>) -> Void) {
        database.collection(collection)
            .whereField("id_psycologist", isEqualTo: psycologistId)
            .addSnapshotListener { query, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                let comments = query?.documents.compactMap { try? $0.data(as: CommentModel.self) } ?? []
                completion(.success(comments))
            }
    }

    func addComment(comment: CommentModel, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            _ = try database.collection(collection).addDocument(from: comment) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
