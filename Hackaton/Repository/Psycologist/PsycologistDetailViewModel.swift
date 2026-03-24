//
//  PsycologistDetailViewModel.swift
//  Hackaton
//
//  Created by Annete Morado on 24/03/26.
//

import Foundation
import Combine

final class PsycologistDetailViewModel: ObservableObject {
    @Published var comments: [CommentModel] = []
    @Published var messageError: String?

    private let currentUserId = "test_user_123"
    private let commentRepository = CommentRepository()
    private let appointmentRepository = AppointmentRepository()

    func getComments(psycologistId: String) {
        commentRepository.getCommentsByPsycologist(psycologistId: psycologistId) { [weak self] result in
            switch result {
            case .success(let comments):
                self?.comments = comments
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }

    func addComment(psycologistId: String, comment: String, rating: Int) {
        let newComment = CommentModel(
            comment: comment,
            id_psycologist: psycologistId,
            id_user: currentUserId,
            rating: rating
        )
        commentRepository.addComment(comment: newComment) { [weak self] result in
            if case .failure(let error) = result {
                self?.messageError = error.localizedDescription
            }
        }
    }

    func bookAppointment(psycologistId: String, date: String, hour: String) {
        let appointment = AppointmentModel(
            comment: "",
            date: date,
            hour: hour,
            id_psycologist: psycologistId,
            id_user: currentUserId,
            estado: "pendiente",
            location: "Consultorio virtual",
            calificacion: 0
        )
        appointmentRepository.addAppointment(appointment: appointment) { [weak self] result in
            if case .failure(let error) = result {
                self?.messageError = error.localizedDescription
            }
        }
    }

    var averageRating: Double {
        guard !comments.isEmpty else { return 0 }
        return Double(comments.map { $0.rating }.reduce(0, +)) / Double(comments.count)
    }
}
