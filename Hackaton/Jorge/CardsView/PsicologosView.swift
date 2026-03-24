import SwiftUI

struct HomeView2: View
{
    @State private var position: CGSize = CGSize(width: -5, height: -690)
    @GestureState private var dragOffset: CGSize = .zero
    @State private var goToChat = false
    @State private var selectedFilter: String? = nil
    
    var body: some View
    {
        NavigationStack
        {
            ZStack
            {
                ZStack
                {
                    Circle()
                        .fill(Color.green.opacity(0.2))
                        .frame(width: 300, height: 300)
                        .offset(x: -120, y: -400)

                    Circle()
                        .fill(Color.green.opacity(0.3))
                        .frame(width: 250, height: 250)
                        .offset(x: -150, y: -400)

                    Circle()
                        .fill(Color.green.opacity(0.18))
                        .frame(width: 200, height: 200)
                        .offset(x: 0, y: -450)
                    
                    Circle()
                        .fill(Color.green.opacity(0.2))
                        .frame(width: 300, height: 330)
                        .offset(x: 120, y: 400)

                    Circle()
                        .fill(Color.green.opacity(0.3))
                        .frame(width: 250, height: 350)
                        .offset(x: 150, y: 400)

                    Circle()
                        .fill(Color.green.opacity(0.18))
                        .frame(width: 200, height: 250)
                        .offset(x: 30, y: 450)
                }
                .ignoresSafeArea()

                ScrollView
                {
                    VStack(alignment: .center, spacing: 12)
                    {
                        searchBarPsicologos()
                            .padding(.leading, 16)
                            .padding(.top, 8)
                            .padding(.bottom, 24)
                        
                        Text("Selecciona tu próximo viaje:")
                            .padding(.leading, -90)
                            .padding(.bottom, 12)
                            .font(.system(size: 22, weight: .bold))
                        
                        ScrollView(.horizontal, showsIndicators: false)
                        {
                            HStack
                            {
                                filterButton("#Clínico")
                                filterButton("#Psicoterapeuta")
                                filterButton("#Tanátologo")
                                filterButton("#Neuropsicólogo")
                                filterButton("#Familiar")
                                filterButton("#Pareja")
                                filterButton("#Infantil")
                                filterButton("#Pareja")
                                filterButton("#rehabilitación")
                                filterButton("#Gerontólogo")
                            }
                            .padding(.leading, 16)
                        }
                        .padding(.bottom, 16)
                        
                        SwipeCardsView(
                            cards: [
                                TravelCard(title: "Juan, Psicoterapeuta", subtitle: "Edo Mex, 19 años", imageName: "psico1"),
                                TravelCard(title: "Arturo, Psicólogo", subtitle: "CDMX, 25 años", imageName: "psico2"),
                                TravelCard(title: "Joaquin, Familiar ", subtitle: "CDMX, 28 años", imageName: "psico3"),
                                TravelCard(title: "Paola, reabilitación", subtitle: "Edo Mex, 25 años", imageName: "psico4")
                            ]
                        )
                    }
                    .padding(.bottom, 100)
                    .padding(.top, 10)
                }
                
                VStack
                {
                    Spacer()
                    
                    HStack
                    {
                        Spacer()
                        
                        Image("poñoñonfel")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .background(.white.opacity(0.95))
                            .clipShape(Circle())
                            .contentShape(Circle())
                            .shadow(color: .green.opacity(0.1), radius: 15)
                            .shadow(color: .blue.opacity(0.1), radius: 30)
                            .offset(
                                x: position.width + dragOffset.width,
                                y: position.height + dragOffset.height
                            )
                            .onTapGesture {
                                goToChat = true
                            }
                            .gesture(
                                DragGesture()
                                    .updating($dragOffset) { value, state, _ in
                                        state = value.translation
                                    }
                                    .onEnded { value in
                                        position = CGSize(
                                            width: position.width + value.translation.width,
                                            height: position.height + value.translation.height
                                        )
                                    }
                            )
                            .padding(.trailing, 20)
                            .padding(.bottom, 20)
                    }
                }
            }
            .navigationTitle("Psicologos")
            .toolbar
            {
                ToolbarItem(placement: .principal)
                {
                    VStack
                    {
                        Text("Home")
                        Text("Mar 24 2026")
                            .font(.subheadline)
                    }
                }
            }
            .navigationDestination(isPresented: $goToChat)
            {
                ChatView()
            }
        }
    }
    
    @ViewBuilder
    private func filterButton(_ text: String) -> some View
    {
        Button
        {
            if selectedFilter == text
            {
                selectedFilter = nil
            }
            else
            {
                selectedFilter = text
            }
        }
        label:
        {
            filters(text: text)
                .padding(.horizontal, 4)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(selectedFilter == text ? Color.green.opacity(0.18) : Color.clear)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(
                            selectedFilter == text ? Color.green.opacity(0.55) : Color.clear,
                            lineWidth: 1.5
                        )
                )
                .scaleEffect(selectedFilter == text ? 1.03 : 1.0)
                .shadow(
                    color: selectedFilter == text ? Color.green.opacity(0.15) : Color.clear,
                    radius: 8,
                    x: 0,
                    y: 4
                )
                .animation(.easeInOut(duration: 0.18), value: selectedFilter)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HomeView2()
}
