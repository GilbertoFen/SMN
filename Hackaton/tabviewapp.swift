import SwiftUI

struct tabviewapp: View
{
    
    
    var body: some View
    {
        TabView
        {
            HomeView(currentUserId: "1").tabItem()
            {
                Label("Home", systemImage: "house.fill")
            }
            
            CardView().environment(ModelData()).tabItem
            {
                Label("Info", systemImage: "info.circle.text.page")
            }
            HomeView2().tabItem()
            {
                Label("Psicologos", systemImage: "person.2")
            }
            
            StatsView(currentUserId: "1")
                                .tabItem { Label("Stats", systemImage: "chart.line.uptrend.xyaxis") }
            
    
        }.tint(.black)
    }
}

#Preview {
    tabviewapp()
}
