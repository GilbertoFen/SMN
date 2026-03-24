
import Foundation
import FirebaseFirestore

struct NoteModel: Identifiable, Decodable {
    @DocumentID var id: String?
    let content: String
    let date: String
    let id_user: String
    let rating: Double
}

final class NoteDataSource {
    private let database = Firestore.firestore()
    private let collection = "notes"

    func getNotesByUser(userId: String, completion: @escaping (Result<[NoteModel], Error>) -> Void) {
        database.collection(collection)
            .whereField("id_user", isEqualTo: userId)
            .addSnapshotListener { query, error in
                if let error = error {
                    print("❌ Error notas: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }
                print("📄 Notas encontradas: \(query?.documents.count ?? 0)")
                let notes = query?.documents.compactMap { try? $0.data(as: NoteModel.self) } ?? []
                print("✅ Notas parseadas: \(notes.count)")
                completion(.success(notes))
            }
    }}
