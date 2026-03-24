import Foundation
import Combine
import FirebaseAuth

final class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentUserId: String = ""
    @Published var currentUserName: String = ""
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var currentUserEmail: String = ""
    
    private let repository = AuthRepository()

    init() {
        if let user = repository.getCurrentUser() {
            self.isLoggedIn = true
            self.currentUserId = user.uid
            self.currentUserName = user.displayName ?? "Usuario"
            self.currentUserEmail = user.email ?? ""
        }
    }

    func login(email: String, password: String) {
        isLoading = true
        errorMessage = nil
        repository.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let user):
                    self?.currentUserId = user.uid
                    self?.currentUserName = user.displayName ?? "Usuario"
                    self?.isLoggedIn = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func register(email: String, password: String, name: String) {
        isLoading = true
        errorMessage = nil
        repository.register(email: email, password: password, name: name) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let user):
                    self?.currentUserId = user.uid
                    self?.currentUserName = user.displayName ?? "Usuario"
                    self?.isLoggedIn = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func logout() {
        try? repository.logout()
        isLoggedIn = false
        currentUserId = ""
        currentUserName = ""
    }
    
    func changePassword(current: String, new: String, completion: @escaping (Bool) -> Void) {
        guard let user = repository.getCurrentUser(),
              let email = user.email else { return }
        isLoading = true
        errorMessage = nil

        // Re-autenticar primero
        let credential = EmailAuthProvider.credential(withEmail: email, password: current)
        user.reauthenticate(with: credential) { _, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "Contraseña actual incorrecta"
                }
                return
            }
            user.updatePassword(to: new) { error in
                DispatchQueue.main.async {
                    self.isLoading = false
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                        completion(false)
                    } else {
                        completion(true)
                    }
                }
            }
        }
    }
}
