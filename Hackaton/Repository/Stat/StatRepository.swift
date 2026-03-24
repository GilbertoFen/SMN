//
//  StatRepository.swift
//  Hackaton
//
//  Created by Annete Morado on 24/03/26.
//
import Foundation

final class StatRepository {
    private let dataSource = StatDataSource()

    func getStatsByUser(userId: String, completion: @escaping (Result<[StatModel], Error>) -> Void) {
        dataSource.getStatsByUser(userId: userId, completion: completion)
    }
}
