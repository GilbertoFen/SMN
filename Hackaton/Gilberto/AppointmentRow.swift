// AppointmentRow.swift
import SwiftUI

struct AppointmentRow: View {
    
    struct StatusBadge: View {
        var estado: String
        var color: Color {
            switch estado.lowercased() {
            case "realizada": return .green
            case "pendiente": return .orange
            default: return .gray
            }
        }
        var body: some View {
            Text(estado.capitalized)
                .font(.caption)
                .fontWeight(.semibold)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(color.opacity(0.15))
                .foregroundColor(color)
                .cornerRadius(6)
        }
    }
    
    var appointment: AppointmentModel  // <- AppointmentModel

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(formatDateString(stringDate: appointment.date))
                        .font(.system(size: 16, weight: .bold))
                    Text(appointment.hour)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                Spacer()
                if appointment.estado.lowercased() == "realizada" {
                    StatusBadge(estado: appointment.estado)
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)

            AnimatedDropdownMenu(appointment: appointment)
                .padding(.horizontal)
                .padding(.bottom, 8)
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2)
    }
}
