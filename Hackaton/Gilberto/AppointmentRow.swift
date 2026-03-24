//
//  Appointment.swift
//  SMN
//
//  Created by Gil Avalos on 23/03/26.
//

import SwiftUI

struct AppointmentRow: View {
    var appointment: Appointment

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(formatDateString(stringDate : appointment.date))
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

struct TextLabel: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.system(size: 20, weight: .bold))
            .padding()
    }
}

#Preview {
    let modelData = ModelData()
    return AppointmentRow(appointment: modelData.appointments[2])
        .padding()
}
