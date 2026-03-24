// AppointmentsContentView.swift
import SwiftUI

struct ContentView: View {
    @ObservedObject var appointmentViewModel: AppointmentViewModel
    @State private var showAllAppointments = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {

                    // Calendario con citas reales
                    CalendarView(appointments: appointmentViewModel.appointments)

                    // Botón agendar cita
                    NavigationLink(destination: HomeView2(psycologistViewModel: PsycologistViewModel())) {
                        HStack {
                            Image(systemName: "calendar.badge.plus")
                            Text("Agenda tu cita")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                    }

                    // Lista de citas
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Tus citas recientes")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.horizontal)
                            .padding(.top, 8)

                        let displayed = showAllAppointments
                            ? appointmentViewModel.appointments
                            : Array(appointmentViewModel.appointments.prefix(3))

                        ForEach(displayed) { appointment in
                            AppointmentRow(appointment: appointment)
                                .padding(.horizontal)
                        }
                    }

                    if appointmentViewModel.appointments.count > 3 {
                        Button(action: {
                            withAnimation { showAllAppointments.toggle() }
                        }) {
                            Text(showAllAppointments ? "Ver menos" : "Ver más")
                                .foregroundColor(.blue)
                                .fontWeight(.medium)
                                .padding(.vertical, 12)
                        }
                    }
                }
            }
            .navigationTitle("Mis Citas")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                appointmentViewModel.getAppointments()
            }
        }
    }
}
