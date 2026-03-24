import SwiftUI

struct tabviewOnboarding: View
{
    @State private var currentPage = 0
    @State private var goToHome = false

    var body: some View
    {
        if goToHome
        {
            HomeView(currentUserId: "test_user_123")
        }
        else
        {
            TabView(selection: $currentPage)
            {
                Onboarding0(onNext: {
                    withAnimation { currentPage = 1 }
                })
                .tag(0)

                Onboarding(onNext: {
                    withAnimation { currentPage = 2 }
                })
                .tag(1)

                DailyCheckIn(onTerminar: {
                    withAnimation(.easeInOut) { goToHome = true }
                })
                .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()
        }
    }
}

#Preview
{
    tabviewOnboarding()
}
