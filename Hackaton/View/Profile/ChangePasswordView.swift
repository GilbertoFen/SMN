// ChangePasswordView.swift
import SwiftUI

struct ChangePasswordView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss

    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var showSuccess = false

    var body: some View {
        NavigationStack {
            List {
                Section("Contraseña actual") {
                    SecureField("Contraseña actual", text: $currentPassword)
                }

                Section("Nueva contraseña") {
                    SecureField("Nueva contraseña", text: $newPassword)
                    SecureField("Confirmar contraseña", text: $confirmPassword)
                }

                if let error = authViewModel.errorMessage {
                    Section {
                        Text(error)
                            .foregroundStyle(.red)
                            .font(.caption)
                    }
                }

                Section {
                    Button(action: changePassword) {
                        if authViewModel.isLoading {
                            ProgressView()
                        } else {
                            Text("Actualizar contraseña")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundStyle(.indigo)
                        }
                    }
                    .disabled(authViewModel.isLoading)
                }
            }
            .navigationTitle("Cambiar contraseña")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancelar") { dismiss() }
                }
            }
            .alert("¡Contraseña actualizada!", isPresented: $showSuccess) {
                Button("OK") { dismiss() }
            }
        }
    }

    private func changePassword() {
        guard newPassword == confirmPassword else {
            authViewModel.errorMessage = "Las contraseñas no coinciden"
            return
        }
        guard newPassword.count >= 6 else {
            authViewModel.errorMessage = "La contraseña debe tener al menos 6 caracteres"
            return
        }
        authViewModel.changePassword(current: currentPassword, new: newPassword) { success in
            if success { showSuccess = true }
        }
    }
}

#Preview {
    ChangePasswordView(authViewModel: AuthViewModel())
}
