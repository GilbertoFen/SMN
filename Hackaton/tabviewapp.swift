import SwiftUI

struct tabviewapp: View {
    @ObservedObject var authViewModel: AuthViewModel

    var body: some View {
        TabView {
            HomeView(currentUserId: authViewModel.currentUserId, authViewModel: authViewModel)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            CardView()
                .environment(ModelData())
                .tabItem {
                    Label("Info", systemImage: "info.circle.text.page")
                }

            HomeView2(psycologistViewModel: PsycologistViewModel())
                .tabItem {
                    Label("Psicólogos", systemImage: "person.2")
                }

            StatsView(currentUserId: authViewModel.currentUserId)
                .tabItem {
                    Label("Stats", systemImage: "chart.line.uptrend.xyaxis")
                }
            
            AppointmentsView(authViewModel: authViewModel)
                .tabItem {
                    Label("Citas", systemImage: "calendar")
                }
        }
        .tint(.black)
    }
}

#Preview {
    tabviewapp(authViewModel: AuthViewModel())
}
