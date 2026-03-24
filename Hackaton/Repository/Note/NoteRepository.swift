//
//  NoteRepository.swift
//  Hackaton
//

import Foundation

final class NoteRepository {
    private let dataSource = NoteDataSource()

    func getNotesByUser(userId: String, completion: @escaping (Result<[NoteModel], Error>) -> Void) {
        dataSource.getNotesByUser(userId: userId, completion: completion)
    }
}
