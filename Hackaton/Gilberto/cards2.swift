//
//  ContentView.swift
//  SMN
//
//  Created by Gil Avalos on 23/03/26.
//

import SwiftUI
import SwiftData

//  ContentView.swift
import SwiftUI

struct ContentView: View {
    @State private var modelData = ModelData()
    @State private var showAllAppointments = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    CalendarView(appointments: modelData.appointments)
                    

                    NavigationLink(destination: ScheduleView()) {
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

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Tus citas recientes")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.horizontal)
                            .padding(.top, 8)

                        let displayed = showAllAppointments
                            ? modelData.appointments
                            : Array(modelData.appointments.prefix(3))

                        ForEach(displayed) { appointment in
                            AppointmentRow(appointment: appointment)
                                .padding(.horizontal)
                        }
                    }

                    if modelData.appointments.count > 3 {
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
        }
        .environment(modelData)
    }
}


