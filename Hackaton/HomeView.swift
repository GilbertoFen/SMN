//
//  ContentView.swift
//  Hackaton
//
//  Created by Annete Morado on 23/03/26.
//

import SwiftUI

struct HomeView: View {
    @Environment(ModelData.self) var modelData
    var psycology: Psycologist
    var appointment: Appointment
    var issues: [Issue]
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // CITA
                    
                    
                    VStack(alignment: .leading, spacing: 0.8){
                            Text("Próxima consulta")
                                .font(.title2)
                                .bold()
                                .padding(.bottom, 10)
                        
                            Button(action: {
                                selectedTab = .calendar
                            }){
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(appointment.date)
                                        .font(.headline)
                                    Text(appointment.id_psycologist)
                                        .font(.title3)
                                }
                                Spacer()
                                Text(appointment.hour)
                                    .font(.headline)
                            }
                            .padding()
                        }
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                        
                    
                    
                    // ISSUES
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Temas")
                            .font(.title2)
                            .bold()
                        
                        ForEach(issues) { issue in
                            NavigationLink {
                                // Destino: puedes pasar el issue si más adelante IssueCardsView lo requiere
                                IssueCardsView()
                            } label: {
                                HStack(spacing: 12) {
                                    Image(systemName: issue.imageIssue)
                                        .imageScale(.large)
                                    Text(issue.issue)
                                        .font(.body)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.secondary)
                                }
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }
                    }
                    
                    // MAPA
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ubicación")
                            .font(.title2)
                            .bold()
                        MapView(coordinate: psycology.locationCoordinates)
                            .frame(height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding()
            }
            .navigationTitle("Hola, Marisol")
        }
    }
}

#Preview {
    let modelData = ModelData()
    
    HomeView(psycology: modelData.psycologists[0],
             appointment: modelData.appointments[0],
             issues: modelData.issues,
             selectedTab: .constant(Tab.home))
        .environment(modelData)
}
