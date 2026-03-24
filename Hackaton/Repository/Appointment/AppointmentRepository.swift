//
//  AppointmentRepository.swift
//  Hackaton
//
//  Created by Annete Morado on 24/03/26.
//

// AppointmentRepository.swift
import Foundation

final class AppointmentRepository {
    private let dataSource = AppointmentDataSource()

    func getAppointmentsByUser(userId: String, completion: @escaping (Result<[AppointmentModel], Error>) -> Void) {
        dataSource.getAppointmentsByUser(userId: userId, completion: completion)
    }
    
    func addAppointment(appointment: AppointmentModel, completion: @escaping (Result<Void, Error>) -> Void) {
        dataSource.addAppointment(appointment: appointment, completion: completion)
    }
}
