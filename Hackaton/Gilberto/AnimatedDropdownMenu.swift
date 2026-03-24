// AnimatedDropdownMenu.swift
import SwiftUI

struct AnimatedDropdownMenu: View {
    @State private var isExpanded = false
    var appointment: AppointmentModel  // <- AppointmentModel

    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text("Ver detalles")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.blue)
                        .font(.caption)
                }
                .padding(.vertical, 10)
            }

            if isExpanded {
                VStack(alignment: .leading, spacing: 10) {
                    Divider()

                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.green.opacity(0.7))
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Ubicación")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(appointment.location)
                                .font(.subheadline)
                        }
                    }

                    if !appointment.comment.isEmpty {
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "text.bubble.fill")
                                .foregroundColor(.green.opacity(0.4))
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Comentario")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(appointment.comment)
                                    .font(.subheadline)
                            }
                        }
                    }

                    if appointment.estado.lowercased() == "realizada" {
                        HStack(spacing: 8) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Calificación")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                HStack(spacing: 2) {
                                    ForEach(1...5, id: \.self) { i in
                                        Image(systemName: i <= appointment.calificacion ? "star.fill" : "star")
                                            .foregroundColor(.yellow)
                                            .font(.caption)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, 12)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
}
