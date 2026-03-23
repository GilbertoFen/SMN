//
//  ContentView.swift
//  Hackaton
//
//  Created by Annete Morado on 23/03/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(ModelData.self) var modelData
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        TabView(selection: $selectedTab){
            HomeView(psycology: modelData.psycologists[0],
                     appointment: modelData.appointments[0],
                     issues: modelData.issues,
                    selectedTab: $selectedTab)
            .tabItem{
                Label("Home", systemImage: "house")
            }
            .tag(Tab.home)
            
            CalendarView()
            .tabItem{
                Label("Calendar", systemImage: "calendar")
            }
            .tag(Tab.calendar)
            
            DiaryView(graphics: modelData.graphics)
                .tabItem {
                    Label("Diary", systemImage: "book")
                }
                .tag(Tab.diary)
        }
        
        
        
        
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
