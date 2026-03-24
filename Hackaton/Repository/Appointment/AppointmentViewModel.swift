//
//  AppointmentViewModel.swift
//  Hackaton
//
//  Created by Annete Morado on 24/03/26.
//
import Foundation
import Combine

final class AppointmentViewModel: ObservableObject {
    @Published var appointments: [AppointmentModel] = []
    @Published var messageError: String?

    private let currentUserId: String
    init(userId: String) {
        self.currentUserId = userId
    }

    private let repository = AppointmentRepository()

    func getAppointments() {
        repository.getAppointmentsByUser(userId: currentUserId) { [weak self] result in
            switch result {
            case .success(let appointments):
                print(appointments)
                self?.appointments = appointments
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }

    // Devuelve la próxima cita (la más próxima por fecha y hora)
    var nextAppointment: AppointmentModel? {
        appointments
            .filter { $0.date >= todayString }
            .sorted { $0.date + $0.hour < $1.date + $1.hour }
            .first
    }

    private var todayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
}
