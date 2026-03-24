import SwiftUI

struct CardView: View {
    @Environment(ModelData.self) var modelData
    @Namespace private var cardNamespace
    @State private var expandedCard: CardInfo? = nil
    @State private var isFlipped = false
    @State private var navigationPath = NavigationPath()

    private let columns = [
        GridItem(.adaptive(minimum: 160, maximum: 220), spacing: 12)
    ]

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack
            {
                // FONDO
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                ZStack {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(modelData.disorders) { card in
                                CardComponent(
                                    card: card,
                                    namespace: cardNamespace,
                                    isExpanded: false,
                                    onTap: {
                                        withAnimation(.spring(response: 0.5, dampingFraction: 0.82)) {
                                            expandedCard = card
                                            isFlipped = false
                                        }
                                    }
                                )
                                .opacity(expandedCard?.id == card.id ? 0 : 1)
                            }
                        }
                        .padding(.horizontal, 14)
                        .padding(.top, 8)
                        .padding(.bottom, 16)
                    }
                    .background(Color(.systemGroupedBackground))

                    if let card = expandedCard {
                        Color.black.opacity(0.45)
                            .ignoresSafeArea()
                            .onTapGesture { collapse() }

                        CardComponent(
                            card: card,
                            namespace: cardNamespace,
                            isExpanded: true,
                            externalFlip: $isFlipped,
                            onTap: {
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                    isFlipped.toggle()
                                }
                            },
                            onCollapse: { collapse() },
                            onNavigateToHelp: {
                                collapse()
                                navigationPath.append(card)
                            }
                        )
                        .padding(16)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .ignoresSafeArea()
                    }
                }
            }
            .navigationTitle("Transtornos")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: CardInfo.self) { card in
                HelpView()
            }
        }
    }

    private func collapse() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.82)) {
            isFlipped = false
            expandedCard = nil
        }
    }
}

#Preview {
    CardView().environment(ModelData())
}
