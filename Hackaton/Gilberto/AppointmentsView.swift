//
//  AppointmentsView 2.swift
//  Hackaton
//
//  Created by Annete Morado on 24/03/26.
//
import SwiftUI

struct AppointmentsView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @StateObject var appointmentViewModel: AppointmentViewModel

    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
        _appointmentViewModel = StateObject(wrappedValue: AppointmentViewModel(userId: authViewModel.currentUserId))
    }

    var body: some View {
        ContentView(appointmentViewModel: appointmentViewModel)
    }
}

#Preview {
    AppointmentsView(authViewModel: AuthViewModel())
}
