//
//  AuthRepository.swift
//  Hackaton
//
//  Created by Annete Morado on 24/03/26.

import Foundation
import FirebaseAuth

final class AuthRepository {
    private let dataSource = AuthDataSource()

    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        dataSource.login(email: email, password: password, completion: completion)
    }

    func register(email: String, password: String, name: String, completion: @escaping (Result<User, Error>) -> Void) {
        dataSource.register(email: email, password: password, name: name, completion: completion)
    }

    func logout() throws {
        try dataSource.logout()
    }

    func getCurrentUser() -> User? {
        dataSource.getCurrentUser()
    }
}
