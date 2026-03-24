// StatViewModel.swift
import Foundation
import Combine

final class StatViewModel: ObservableObject {
    @Published var stats: [StatModel] = []
    @Published var notes: [NoteModel] = []
    @Published var selectedEmotion: String = "All"
    @Published var messageError: String?

    private let currentUserId: String
    private let statRepository: StatRepository
    private let noteRepository: NoteRepository

    let emotions = ["All", "Feliz", "Triste", "Enojado", "Ansiedad", "Calma"]

    init(userId: String) {
        self.currentUserId = userId
        self.statRepository = StatRepository()
        self.noteRepository = NoteRepository()
    }

    func getStats() {
        statRepository.getStatsByUser(userId: currentUserId) { [weak self] result in
            switch result {
            case .success(let stats):
                self?.stats = stats
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }

    func getNotes() {
        print("🔍 Buscando notas para userId: \(currentUserId)")
        noteRepository.getNotesByUser(userId: currentUserId) { [weak self] result in
            switch result {
            case .success(let notes):
                self?.notes = notes
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }

    // Solo notas con rating >= 0.5
    var relevantNotes: [NoteModel] {
        notes
            .filter { $0.rating >= 0.5 }
            .sorted { $0.date > $1.date }
    }

    var filteredStats: [StatModel] {
        let filtered = selectedEmotion == "All"
            ? stats
            : stats.filter { $0.emotion.lowercased() == selectedEmotion.lowercased() }
        return filtered
            .filter { $0.date >= thirtyDaysAgoString }
            .sorted { $0.date < $1.date }
    }

    private var thirtyDaysAgoString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: Date()) ?? Date()
        return formatter.string(from: thirtyDaysAgo)
    }
}
