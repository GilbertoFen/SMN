import SwiftUI

struct TypingBubbleView: View
{
    @State private var animate = false

    var body: some View
    {
        HStack(spacing: 6)
        {
            Circle()
                .frame(width: 8, height: 8)
                .scaleEffect(animate ? 1 : 0.5)
                .animation(.easeInOut(duration: 0.6).repeatForever().delay(0), value: animate)

            Circle()
                .frame(width: 8, height: 8)
                .scaleEffect(animate ? 1 : 0.5)
                .animation(.easeInOut(duration: 0.6).repeatForever().delay(0.2), value: animate)

            Circle()
                .frame(width: 8, height: 8)
                .scaleEffect(animate ? 1 : 0.5)
                .animation(.easeInOut(duration: 0.6).repeatForever().delay(0.4), value: animate)
        }
        .foregroundStyle(Color.black.opacity(0.45))
        .onAppear
        {
            animate = true
        }
    }
}

// Renombrada para evitar conflicto con SwipeCardsView definida en otro archivo.
struct ChatCardsCarouselView: View
{
    let cards: [TravelCard]

    var body: some View
    {
        ScrollView(.horizontal, showsIndicators: false)
        {
            HStack(spacing: 14)
            {
                ForEach(cards) { card in
                    VStack(alignment: .leading, spacing: 10)
                    {
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(Color.white.opacity(0.65))
                                .frame(width: 220, height: 120)

                            if UIImage(named: card.imageName) != nil
                            {
                                Image(card.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 220, height: 120)
                                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                            }
                            else
                            {
                                Image(systemName: "photo")
                                    .font(.system(size: 32))
                                    .foregroundStyle(Color.black.opacity(0.25))
                            }
                        }

                        Text(card.title)
                            .font(.system(size: 17, weight: .bold))
                            .foregroundStyle(Color.black.opacity(0.8))

                        Text(card.subtitle)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(Color.black.opacity(0.55))
                            .lineLimit(2)
                    }
                    .padding(12)
                    .frame(width: 240)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .stroke(Color.white.opacity(0.35), lineWidth: 1)
                    )
                }
            }
            .padding(.horizontal, 2)
        }
    }
}

struct Home: View
{
    var body: some View
    {
        VStack(spacing: 16)
        {
            Image(systemName: "house.fill")
                .font(.system(size: 40))
                .foregroundStyle(.green)

            Text("Home")
                .font(.largeTitle.bold())

            Text("Pantalla temporal para que compile.")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}

struct ChatView: View
{
    @State private var message = ""
    @State private var items: [Item] = []
    @State private var goToContent = false
    @State private var travelCards: [TravelCard] = []

    private let serverBaseURL = "http://10.110.0.13:3000"

    var body: some View
    {
        ZStack
        {
            LinearGradient(
                colors: [
                    Color(red: 0.82, green: 0.88, blue: 0.82),
                    Color(red: 0.95, green: 0.92, blue: 0.88),
                    Color(red: 0.98, green: 0.96, blue: 0.94)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 6)
            {
                ScrollViewReader { proxy in
                    ScrollView(.vertical, showsIndicators: false)
                    {
                        VStack(spacing: 16)
                        {
                            ForEach(items) { item in
                                HStack
                                {
                                    if item.isFromUser
                                    {
                                        Spacer()

                                        Text(item.text)
                                            .foregroundStyle(.white)
                                            .font(.system(size: 15, weight: .medium))
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 12)
                                            .background(
                                                LinearGradient(
                                                    colors: [
                                                        Color(red: 0.56, green: 0.67, blue: 0.58),
                                                        Color(red: 0.46, green: 0.58, blue: 0.50)
                                                    ],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )
                                            )
                                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                                    .stroke(Color.white.opacity(0.18), lineWidth: 1)
                                            )
                                            .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 6)
                                            .frame(maxWidth: 260, alignment: .trailing)
                                    }
                                    else
                                    {
                                        Group
                                        {
                                            if item.isTyping
                                            {
                                                TypingBubbleView()
                                                    .padding(.horizontal, 15)
                                                    .padding(.vertical, 12)
                                                    .background(Color.white.opacity(0.55))
                                            }
                                            else
                                            {
                                                Text(item.text)
                                                    .foregroundStyle(Color.black.opacity(0.76))
                                                    .font(.system(size: 15, weight: .medium))
                                                    .padding(.horizontal, 16)
                                                    .padding(.vertical, 12)
                                                    .background(Color.white.opacity(0.55))
                                            }
                                        }
                                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                                .stroke(Color.black.opacity(0.05), lineWidth: 1)
                                        )
                                        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 6)
                                        .frame(maxWidth: 260, alignment: .leading)

                                        Spacer()
                                    }
                                }
                                .id(item.id)
                            }

                            if !travelCards.isEmpty
                            {
                                ChatCardsCarouselView(cards: travelCards)
                                    .padding(.top, 8)
                                    .id("travelCardsSection")
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                        .padding(.bottom, 12)
                    }
                    .onChange(of: items.count) { _, _ in
                        scrollToBottom(proxy: proxy)
                    }
                    .onChange(of: travelCards.count) { _, _ in
                        scrollToBottom(proxy: proxy, targetID: "travelCardsSection")
                    }
                }

                HStack(spacing: 14)
                {
                    Button
                    {
                    } label:
                    {
                        Image(systemName: "folder.badge.plus")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(Color.black.opacity(0.65))
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.55))
                            .clipShape(Circle())
                    }

                    TextField("Escribe algo...", text: $message)
                        .textFieldStyle(.plain)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(Color.black.opacity(0.78))
                        .tint(Color(red: 0.56, green: 0.67, blue: 0.58))
                        .onSubmit
                        {
                            sendMessage()
                        }

                    Button
                    {
                    } label:
                    {
                        Image(systemName: "microphone")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(Color.black.opacity(0.65))
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.55))
                            .clipShape(Circle())
                    }

                    Button
                    {
                        sendMessage()
                    } label:
                    {
                        ZStack
                        {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color(red: 0.56, green: 0.67, blue: 0.58),
                                            Color(red: 0.46, green: 0.58, blue: 0.50)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 46, height: 46)
                                .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 6)

                            Image(systemName: "paperplane.fill")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)
                        }
                    }
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(Color.white.opacity(0.35), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.06), radius: 16, x: 0, y: 8)
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 14)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .toolbar
        {
            ToolbarItem(placement: .principal)
            {
                VStack(spacing: -32)
                {
                    HStack(spacing: 8)
                    {
                        Text("Poñoñón")
                        Image("poñoñonfel")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    }
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(Color.black.opacity(0.78))

                    Text("Ayuda personalizada")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color.black.opacity(0.45))
                        .offset(x: 0, y: 30)
                }
            }
        }
        .navigationDestination(isPresented: $goToContent)
        {
            Home()
        }
    }

    func sendMessage()
    {
        let currentMessage = message.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !currentMessage.isEmpty else { return }

        items.append(Item(text: currentMessage, isFromUser: true))
        message = ""
        travelCards = []

        let typingItem = Item(text: "", isFromUser: false, isTyping: true)
        items.append(typingItem)

        guard let url = URL(string: "\(serverBaseURL)/chat") else
        {
            removeTypingBubble()
            items.append(Item(text: "URL inválida", isFromUser: false))
            return
        }

        let body: [String: String] = [
            "message": currentMessage
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 60
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do
        {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        catch
        {
            DispatchQueue.main.async
            {
                removeTypingBubble()
                items.append(Item(text: "Error al crear el JSON", isFromUser: false))
            }
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error
            {
                DispatchQueue.main.async
                {
                    removeTypingBubble()
                    items.append(Item(text: "Error de red: \(error.localizedDescription)", isFromUser: false))
                }
                return
            }

            guard let data = data else
            {
                DispatchQueue.main.async
                {
                    removeTypingBubble()
                    items.append(Item(text: "No llegaron datos del servidor", isFromUser: false))
                }
                return
            }

            do
            {
                let decoded = try JSONDecoder().decode(ChatResponse.self, from: data)

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8)
                {
                    removeTypingBubble()

                    if let reply = decoded.reply, !reply.isEmpty
                    {
                        items.append(Item(text: reply, isFromUser: false))
                    }
                    else if let error = decoded.error
                    {
                        let detailsText = decoded.details ?? ""
                        let finalMessage = detailsText.isEmpty
                            ? "Error: \(error)"
                            : "Error: \(error)\n\(detailsText)"

                        items.append(Item(text: finalMessage, isFromUser: false))
                    }
                    else
                    {
                        items.append(Item(text: "Respuesta no válida del servidor", isFromUser: false))
                    }

                    switch (decoded.action, decoded.destination)
                    {
                    case ("navigate", "contentView"):
                        goToContent = true

                    case ("show_cards", _):
                        travelCards = decoded.cards ?? []

                    default:
                        break
                    }
                }
            }
            catch
            {
                DispatchQueue.main.async
                {
                    removeTypingBubble()
                    items.append(Item(text: "Error al decodificar la respuesta", isFromUser: false))
                }
            }
        }
        .resume()
    }

    func removeTypingBubble()
    {
        items.removeAll { $0.isTyping }
    }

    func scrollToBottom(proxy: ScrollViewProxy, targetID: AnyHashable? = nil)
    {
        DispatchQueue.main.async
        {
            withAnimation
            {
                if let targetID
                {
                    proxy.scrollTo(targetID, anchor: .bottom)
                }
                else if let lastID = items.last?.id
                {
                    proxy.scrollTo(lastID, anchor: .bottom)
                }
            }
        }
    }
}

#Preview
{
    NavigationStack
    {
        ChatView()
    }
}
