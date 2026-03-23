//
//  ContentView.swift
//  SMN
//
//  Created by Gil Avalos on 23/03/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var modelData = ModelData()
    
    var body: some View {
        VStack{
            CalendarView()
            AppointmentComponent(appointment : modelData.appointments[0]).environment(modelData)
            MoreButton()
        }
        
    }
}


