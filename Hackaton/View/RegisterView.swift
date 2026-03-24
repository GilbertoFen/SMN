//
//  RegisterView.swift
//  Hackaton
//
//  Created by Annete Morado on 24/03/26.

import SwiftUI

struct RegisterView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var name: String = ""
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            VStack(spacing: 8) {
                Image(systemName: "person.badge.plus")
                    .font(.system(size: 60))
                    .foregroundStyle(.indigo)
                Text("Crear cuenta")
                    .font(.largeTitle)
                    .bold()
                Text("Regístrate para empezar")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            VStack(spacing: 14) {
                TextField("Nombre", text: $name)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                TextField("Correo electrónico", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                SecureField("Contraseña", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                SecureField("Confirmar contraseña", text: $confirmPassword)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            if let error = authViewModel.errorMessage {
                Text(error)
                    .font(.caption)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
            }

            Button(action: {
                guard password == confirmPassword else {
                    authViewModel.errorMessage = "Las contraseñas no coinciden"
                    return
                }
                authViewModel.register(email: email, password: password, name: name)
            }) {
                if authViewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text("Crear cuenta")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.indigo)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .disabled(authViewModel.isLoading)

            Button(action: { dismiss() }) {
                HStack {
                    Text("¿Ya tienes cuenta?")
                        .foregroundStyle(.secondary)
                    Text("Inicia sesión")
                        .foregroundStyle(.indigo)
                        .bold()
                }
                .font(.subheadline)
            }

            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RegisterView(authViewModel: AuthViewModel())
}
