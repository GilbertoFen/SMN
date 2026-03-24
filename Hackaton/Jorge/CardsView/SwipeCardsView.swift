import SwiftUI

struct SwipeCardsView: View
{
    let cards: [TravelCard]

    @State private var currentIndex = 0
    @State private var dragOffset: CGSize = .zero
    @State private var selectedCard: TravelCard? = nil
    @State private var isDragging = false

    var body: some View
    {
        VStack(spacing: 12)
        {
            if !cards.isEmpty
            {
                cardsStack
                counterText
            }
        }
        .padding()
        .onChange(of: cards) { _, newCards in
            handleCardsChange(newCards)
        }
        .navigationDestination(item: $selectedCard) { card in
            if let psycologist = card.psycologist {
                PsycologistDetailView(psycologist: psycologist)
            } else {
                Text("Psicólogo no disponible")
            }
        }
    }

    private var cardsStack: some View
    {
        ZStack
        {
            ForEach(Array(visibleCards.enumerated()), id: \.element) { index, cardIndex in
                cardView(for: index, cardIndex: cardIndex)
            }
        }
        .frame(height: 320)
        .padding(.bottom, -4)
    }

    private var counterText: some View
    {
        Text("Card \(currentIndex + 1) de \(cards.count)")
            .font(.subheadline)
            .foregroundColor(.secondary)
    }

    @ViewBuilder
    private func cardView(for index: Int, cardIndex: Int) -> some View
    {
        let isTopCard = index == 0
        let card = cards[cardIndex]

        let baseCard = CardsView(
            imageName: card.imageName,
            title: card.title,
            subtitle: card.subtitle,
            parallaxOffset: isTopCard ? dragOffset.width : 0,
            color: colorForCard(at: cardIndex)
        )
        .scaleEffect(1 - CGFloat(index) * 0.05)
        .offset(
            x: isTopCard ? dragOffset.width : 0,
            y: CGFloat(index) * 14
        )
        .rotationEffect(.degrees(isTopCard ? Double(dragOffset.width / 20) : 0))
        .zIndex(Double(visibleCards.count - index))
        .animation(.spring(response: 0.35, dampingFraction: 0.82), value: currentIndex)
        .animation(.spring(response: 0.22, dampingFraction: 0.92), value: dragOffset)
        .onTapGesture
        {
            guard isTopCard else { return }
            guard !isDragging else { return }
            guard abs(dragOffset.width) < 10 else { return }

            selectedCard = card
        }

        if isTopCard
        {
            baseCard.gesture(dragGesture)
        }
        else
        {
            baseCard
        }
    }

    private var visibleCards: [Int]
    {
        guard !cards.isEmpty else { return [] }
        return Array(currentIndex..<min(currentIndex + 3, cards.count))
    }

    private var dragGesture: some Gesture
    {
        DragGesture()
            .onChanged { value in
                isDragging = true
                dragOffset = value.translation
            }
            .onEnded { value in
                handleSwipe(value)

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05)
                {
                    isDragging = false
                }
            }
    }

    private func handleCardsChange(_ newCards: [TravelCard])
    {
        if newCards.isEmpty
        {
            currentIndex = 0
            dragOffset = .zero
            selectedCard = nil
            isDragging = false
        }
        else if currentIndex >= newCards.count
        {
            currentIndex = max(0, newCards.count - 1)
            dragOffset = .zero
        }
    }

    private func handleSwipe(_ value: DragGesture.Value)
    {
        let threshold: CGFloat = 100

        if value.translation.width < -threshold
        {
            nextCard()
        }
        else if value.translation.width > threshold
        {
            previousCard()
        }
        else
        {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.82))
            {
                dragOffset = .zero
            }
        }
    }

    private func nextCard()
    {
        guard currentIndex < cards.count - 1 else
        {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.82))
            {
                dragOffset = .zero
            }
            return
        }

        withAnimation(.spring(response: 0.28, dampingFraction: 0.82))
        {
            dragOffset = CGSize(width: -420, height: 0)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.18)
        {
            currentIndex += 1
            dragOffset = .zero
        }
    }

    private func previousCard()
    {
        guard currentIndex > 0 else
        {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.82))
            {
                dragOffset = .zero
            }
            return
        }

        withAnimation(.spring(response: 0.28, dampingFraction: 0.82))
        {
            dragOffset = CGSize(width: 420, height: 0)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.18)
        {
            currentIndex -= 1
            dragOffset = .zero
        }
    }

    private func colorForCard(at index: Int) -> Color
    {
        let palette: [Color] = [.blue, .purple, .pink, .orange, .teal, .indigo]
        return palette[index % palette.count]
    }
}

#Preview {
    NavigationStack {
        SwipeCardsView(
            cards: [
                TravelCard(title: "Juan, Psicoterapeuta", subtitle: "Edo Mex, 19 años", imageName: "psico1", psycologist: nil),
                TravelCard(title: "Arturo, Psicólogo", subtitle: "CDMX, 25 años", imageName: "psico2", psycologist: nil),
                TravelCard(title: "Joaquin, Familiar", subtitle: "CDMX, 28 años", imageName: "psico3", psycologist: nil),
                TravelCard(title: "Paola, rehabilitación", subtitle: "Edo Mex, 25 años", imageName: "psico4", psycologist: nil)
            ]
        )
    }
}
