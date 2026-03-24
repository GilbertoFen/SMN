//
//  Appointment.swift
//  Hackaton
//
//  Created by Annete Morado on 24/03/26.
//

import Foundation
import FirebaseFirestore

struct AppointmentModel: Identifiable, Decodable, Encodable {
    @DocumentID var id: String?
    let comment: String
    let date: String
    let hour: String
    let id_psycologist: String
    let id_user: String
}

final class AppointmentDataSource {
    private let database = Firestore.firestore()
    private let collection = "appointments"

    func getAppointmentsByUser(userId: String, completion: @escaping (Result<[AppointmentModel], Error>) -> Void) {
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
                let appointments = documents.compactMap { try? $0.data(as: AppointmentModel.self) }
                completion(.success(appointments))
            }
    }
    
    func addAppointment(appointment: AppointmentModel, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            _ = try database.collection(collection).addDocument(from: appointment) { error in
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
