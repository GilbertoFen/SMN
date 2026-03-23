//
//  Calendar.swift
//  SMN
//
//  Created by Gil Avalos on 23/03/26.
//

import SwiftUI
import UIKit
struct CalendarView: View {
    @State var selectedDate = Date()
    var body: some View {
        NavigationStack{
            VStack{
                TextLabel(text: "Tus proximas Citas").padding()
                DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()
                
                
                NavigationLink{
                    ContentView()
                }label:{
                    Label("Agenda tu cita", systemImage: "folder")}
            }.frame(width: .infinity, height: 50)
        }
            
        
    }
}

#Preview {
    CalendarView(selectedDate: Date())
}
