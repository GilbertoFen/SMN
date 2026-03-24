//
//  AuthDataSource.swift
//  Hackaton
//
//  Created by Annete Morado on 24/03/26.
//
import Foundation

struct AuthModel {
    let email: String
    let password: String
}

import Foundation
import FirebaseAuth

final class AuthDataSource {
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let user = result?.user {
                completion(.success(user))
            }
        }
    }

    func register(email: String, password: String, name: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let user = result?.user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = name
                changeRequest.commitChanges { _ in
                    completion(.success(user))
                }
            }
        }
    }

    func logout() throws {
        try Auth.auth().signOut()
    }

    func getCurrentUser() -> User? {
        Auth.auth().currentUser
    }
}
