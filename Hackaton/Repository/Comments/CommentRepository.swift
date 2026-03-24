//
//  CommentRepository.swift
//  Hackaton
//
//  Created by Annete Morado on 24/03/26.

import Foundation

final class CommentRepository {
    private let dataSource = CommentDataSource()

    func getCommentsByPsycologist(psycologistId: String, completion: @escaping (Result<[CommentModel], Error>) -> Void) {
        dataSource.getCommentsByPsycologist(psycologistId: psycologistId, completion: completion)
    }

    func addComment(comment: CommentModel, completion: @escaping (Result<Void, Error>) -> Void) {
        dataSource.addComment(comment: comment, completion: completion)
    }
}
