import SwiftUI

struct ProfileView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var showLogoutAlert = false
    @State private var notificationsEnabled = false

    private let accentGreen = Color(red: 0.2, green: 0.6, blue: 0.4)
    private let lightGreen  = Color(red: 0.91, green: 0.95, blue: 0.87)
    private let darkGreen   = Color(red: 0.15, green: 0.31, blue: 0.04)

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {

                    // ── Hero header ───────────────────────────────────
                    // FIX 1: GeometryReader para obtener el ancho real del contenedor
                    GeometryReader { geo in
                        ZStack {
                            // FIX 2: Círculos relativos al ancho real, no valores fijos
                            Circle()
                                .fill(accentGreen.opacity(0.13))
                                .frame(width: geo.size.width * 1.1)
                                .offset(x: geo.size.width * 0.25, y: -geo.size.width * 0.55)

                            Circle()
                                .fill(accentGreen.opacity(0.10))
                                .frame(width: geo.size.width * 0.9)
                                .offset(x: -geo.size.width * 0.15, y: -geo.size.width * 0.45)

                            Circle()
                                .fill(accentGreen.opacity(0.08))
                                .frame(width: geo.size.width * 0.65)
                                .offset(x: geo.size.width * 0.2, y: -geo.size.width * 0.15)

                            VStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .fill(lightGreen)
                                        .frame(width: 88, height: 88)
                                        .overlay(Circle().stroke(Color.white, lineWidth: 3))

                                    Text(authViewModel.currentUserName.prefix(1).uppercased())
                                        .font(.system(size: 36, weight: .bold))
                                        .foregroundStyle(darkGreen)
                                }
                                .shadow(color: accentGreen.opacity(0.18), radius: 12, y: 4)

                                VStack(spacing: 4) {
                                    Text(authViewModel.currentUserName)
                                        .font(.system(size: 22, weight: .bold))
                                        .foregroundStyle(Color.black.opacity(0.85))

                                    Text(authViewModel.currentUserEmail)
                                        .font(.system(size: 14))
                                        .foregroundStyle(Color.black.opacity(0.45))
                                }

                                HStack(spacing: 5) {
                                    Circle()
                                        .fill(accentGreen)
                                        .frame(width: 6, height: 6)
                                    Text("Cuenta activa")
                                        .font(.system(size: 11, weight: .medium))
                                        .foregroundStyle(darkGreen)
                                }
                                .padding(.horizontal, 14)
                                .padding(.vertical, 6)
                                .background(lightGreen)
                                .clipShape(Capsule())
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                            .padding(.top, 60)
                        }
                        // FIX 3: clipsContent dentro del GeometryReader para no afectar el layout exterior
                        .frame(width: geo.size.width, height: 280)
                        .clipped()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 280)

                    // ── Secciones ─────────────────────────────────────
                    VStack(spacing: 16) {

                        ProfileSection(title: "Perfil") {
                            ProfileRow(
                                icon: "pencil",
                                iconColor: accentGreen,
                                label: "Editar perfil",
                                destination: AnyView(Text("Editar perfil"))
                            )
                            Divider().padding(.leading, 52)
                            ProfileRow(
                                icon: "lock.fill",
                                iconColor: accentGreen,
                                label: "Seguridad",
                                destination: AnyView(ChangePasswordView(authViewModel: authViewModel))
                            )
                        }

                        ProfileSection(title: "Preferencias") {
                            HStack(spacing: 14) {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(accentGreen.opacity(0.15))
                                    .frame(width: 34, height: 34)
                                    .overlay(
                                        Image(systemName: "bell.fill")
                                            .font(.system(size: 15))
                                            .foregroundStyle(accentGreen)
                                    )
                                Text("Notificaciones")
                                    .font(.system(size: 15))
                                    .foregroundStyle(Color.black.opacity(0.8))
                                Spacer()
                                Toggle("", isOn: $notificationsEnabled)
                                    .tint(accentGreen)
                                    .labelsHidden()
                            }
                            .padding(.vertical, 6)

                            Divider().padding(.leading, 52)

                            ProfileRow(
                                icon: "paintbrush.fill",
                                iconColor: accentGreen,
                                label: "Apariencia",
                                destination: AnyView(Text("Apariencia"))
                            )
                        }

                        ProfileSection(title: "Soporte") {
                            ProfileRow(
                                icon: "questionmark.circle.fill",
                                iconColor: accentGreen,
                                label: "Centro de ayuda",
                                destination: AnyView(Text("Centro de ayuda"))
                            )
                            Divider().padding(.leading, 52)
                            ProfileRow(
                                icon: "info.circle.fill",
                                iconColor: accentGreen,
                                label: "Acerca de",
                                destination: AnyView(Text("Acerca de"))
                            )
                        }

                        // ── Cerrar sesión ─────────────────────────────
                        Button(action: { showLogoutAlert = true }) {
                            HStack(spacing: 10) {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .font(.system(size: 15))
                                Text("Cerrar sesión")
                                    .font(.system(size: 15, weight: .medium))
                            }
                            .foregroundStyle(Color(red: 0.85, green: 0.22, blue: 0.22))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color(red: 0.85, green: 0.22, blue: 0.22).opacity(0.08))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(
                                        Color(red: 0.85, green: 0.22, blue: 0.22).opacity(0.15),
                                        lineWidth: 0.5
                                    )
                            )
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                }
            }
            .ignoresSafeArea(edges: .top)
            .navigationBarTitleDisplayMode(.inline)
            .alert("Cerrar sesión", isPresented: $showLogoutAlert) {
                Button("Cancelar", role: .cancel) {}
                Button("Cerrar sesión", role: .destructive) {
                    authViewModel.logout()
                }
            } message: {
                Text("¿Estás seguro que quieres cerrar sesión?")
            }
        }
    }
}

// ── Subvistas ──────────────────────────────────────────────────────────────

private struct ProfileSection<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(Color.black.opacity(0.35))
                .textCase(.uppercase)
                .kerning(0.6)
                .padding(.leading, 4)
                .padding(.bottom, 8)

            VStack(spacing: 0) {
                content
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black.opacity(0.05), lineWidth: 0.5)
            )
        }
        .frame(maxWidth: .infinity)
    }
}

private struct ProfileRow: View {
    let icon: String
    let iconColor: Color
    let label: String
    let destination: AnyView

    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 14) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(iconColor.opacity(0.15))
                    .frame(width: 34, height: 34)
                    .overlay(
                        Image(systemName: icon)
                            .font(.system(size: 15))
                            .foregroundStyle(iconColor)
                    )
                Text(label)
                    .font(.system(size: 15))
                    .foregroundStyle(Color.black.opacity(0.8))
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(Color.black.opacity(0.2))
            }
            .padding(.vertical, 6)
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ProfileView(authViewModel: AuthViewModel())
}
