import SwiftUI

struct HomeView: View
{
    let currentUserId: String

    @StateObject var appointmentViewModel: AppointmentViewModel
    @StateObject var psycologistViewModel: PsycologistViewModel = PsycologistViewModel()
    @State private var goToChat = false
    @StateObject var authViewModel: AuthViewModel = AuthViewModel()
    
    init(currentUserId: String) {
        self.currentUserId = currentUserId
        _appointmentViewModel = StateObject(wrappedValue: AppointmentViewModel(userId: currentUserId))
    }
    
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
            
            NavigationStack
            {
                ZStack
                {
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 28) {
                            
                            // Proxima Cita
                            VStack(alignment: .leading, spacing: 12) {
                                sectionTitle("Próxima cita")
                                
                                if let appointment = appointmentViewModel.nextAppointment {
                                    NextAppointmentCard(
                                        psychologistName: appointment.id_psycologist,
                                        date: appointment.date,
                                        hour: appointment.hour
                                    )
                                } else {
                                    HStack(spacing: 12) {
                                        Image(systemName: "calendar.badge.plus")
                                            .font(.title2)
                                            .foregroundStyle(.green)
                                        
                                        Text("No tienes citas próximas")
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                    .padding(.vertical, 18)
                                    .padding(.horizontal, 16)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background(
                                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                                            .fill(Color(.secondarySystemBackground))
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                                            .stroke(Color.green.opacity(0.12), lineWidth: 1)
                                    )
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 12)
                            .onAppear {
                                appointmentViewModel.getAppointments()
                            }
                            
                            // Emotions
                            VStack(alignment: .leading, spacing: 16) {
                                sectionTitle("¿Cómo te sientes?")
                                
                                VStack(spacing: 12) {
                                    ForEach(Array(EmotionModel.all.enumerated()), id: \.element.id) { index, emotion in
                                        NavigationLink(destination: EmotionDetailView(emotion: emotion)) {
                                            EmotionMeterCard(
                                                imageName: imageName(for: emotion, index: index),
                                                emotionName: emotion.name,
                                                level: level(for: emotion, index: index)
                                            )
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            
                            // MAPA
                            VStack(alignment: .leading, spacing: 12) {
                                sectionTitle("Psicólogos cerca de ti")
                                
                                MapView(psycologistViewModel: psycologistViewModel)
                                    .frame(height: 260)
                                    .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                                            .stroke(Color.green.opacity(0.12), lineWidth: 1)
                                    )
                                    .shadow(color: Color.green.opacity(0.08), radius: 10, x: 0, y: 6)
                            }
                            .padding(.horizontal, 16)
                            .onAppear {
                                psycologistViewModel.getAllPsycologists()
                            }
                        }
                        .padding(.bottom, 100)
                    }
                    
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            FloatingChatBubble(goToChat: $goToChat)
                                .padding(.trailing, 20)
                                .padding(.bottom, 20)
                        }
                    }
                }
                .navigationTitle("Hola, Marisol")
                .navigationBarTitleDisplayMode(.large)
                .navigationDestination(isPresented: $goToChat) {
                    ChatView()
                }
                .toolbar
                {
                    ToolbarItem(placement: .navigationBarTrailing)
                    {
                        NavigationLink
                        {
                            ProfileView(authViewModel: authViewModel)
                        } label:
                        {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 25))
                                .foregroundStyle(Color.black)
                        }
                    }
                    
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
            }
        }
    
}
    
    @ViewBuilder
    private func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 24, weight: .bold))
            .foregroundStyle(Color.black.opacity(0.88))
            .padding(.bottom, 2)
    }
    
    func imageName(for emotion: EmotionModel, index: Int) -> String {
        switch emotion.name.lowercased() {
        case "felicidad", "feliz":
            return "poñoñonfeli"
        case "tristeza", "triste":
            return "poñoñontite"
        case "ansiedad", "ansioso", "ansiosa":
            return "poñoñonansioso"
        case "enojado", "enojo", "ira":
            return "poñoñonenojayo"
        case "asustado", "calma", "tranquilo", "tranquilidad":
            return "poñoñonfel"
        default:
            let fallbackImages = ["poñoñonfeli", "poñoñontite", "Image"]
            return fallbackImages[index % fallbackImages.count]
        }
    }

    func level(for emotion: EmotionModel, index: Int) -> Double {
        switch emotion.name.lowercased() {
        case "felicidad", "feliz":
            return 0.82
        case "tristeza", "triste":
            return 0.68
        case "ansiedad", "ansioso", "ansiosa":
            return 0.45
        case "enojado", "enojo", "ira":
            return 0.60
        case "calma", "calmado", "tranquilo", "tranquilidad":
            return 0.30
        default:
            let fallbackLevels: [Double] = [0.35, 0.55, 0.75]
            return fallbackLevels[index % fallbackLevels.count]
        
        }
    }
}

struct NextAppointmentCard: View {
    let psychologistName: String
    let date: String
    let hour: String
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white,
                            Color.green.opacity(0.06)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            Circle()
                .fill(Color.green.opacity(0.10))
                .frame(width: 140, height: 140)
                .offset(x: 45, y: -45)
            
            Circle()
                .fill(Color.green.opacity(0.06))
                .frame(width: 90, height: 90)
                .offset(x: 20, y: 18)
            
            VStack(alignment: .leading, spacing: 18) {
                HStack(alignment: .top, spacing: 14) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(Color.green.opacity(0.12))
                            .frame(width: 58, height: 58)
                        
                        Image(systemName: "calendar.badge.clock")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundStyle(Color(red: 0.20, green: 0.60, blue: 0.40))
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Tu próxima cita")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(.secondary)
                        
                        Text(psychologistName)
                            .font(.system(size: 19, weight: .bold))
                            .foregroundStyle(Color.black.opacity(0.85))
                            .lineLimit(1)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 3) {
                        Text(hour)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(Color(red: 0.20, green: 0.60, blue: 0.40))
                        
                        Text("sesión")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(Color.white.opacity(0.92))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(Color.green.opacity(0.18), lineWidth: 1)
                    )
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Label(date, systemImage: "calendar")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(Color.black.opacity(0.68))
                    
                    Label("Psicología general · 50 min", systemImage: "clock")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(Color.black.opacity(0.68))
                }
                
                HStack(spacing: 10) {
                    infoChip(icon: "lock.fill", text: "Sala privada")
                    infoChip(icon: "bubble.left.fill", text: "Chat activo")
                }
                .padding(.top, 2)
            }
            .padding(20)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color.green.opacity(0.22), lineWidth: 1.2)
        )
        .shadow(color: Color.green.opacity(0.10), radius: 14, x: 0, y: 8)
    }
    
    @ViewBuilder
    private func infoChip(icon: String, text: String) -> some View {
        HStack(spacing: 7) {
            Image(systemName: icon)
                .font(.system(size: 11, weight: .semibold))
            Text(text)
                .font(.system(size: 12, weight: .semibold))
        }
        .foregroundStyle(Color(red: 0.20, green: 0.60, blue: 0.40))
        .padding(.horizontal, 12)
        .padding(.vertical, 9)
        .background(Color.green.opacity(0.08))
        .clipShape(Capsule())
    }
}

struct FloatingChatBubble: View {
    @Binding var goToChat: Bool
    
    @State private var position: CGSize = CGSize(width: -300, height: -690)
    @GestureState private var dragOffset: CGSize = .zero
    
    var body: some View {
        Image("poñoñonfel")
            .resizable()
            .scaledToFit()
            .frame(width: 54, height: 54)
            .background(.white.opacity(0.95))
            .clipShape(Circle())
            .contentShape(Circle())
            .shadow(color: .green.opacity(0.12), radius: 12)
            .shadow(color: .blue.opacity(0.10), radius: 24)
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
    }
}

// Placeholder temporal para compilar en ausencia de EmotionMeterCard real.
private struct EmotionMeterCard: View {
    let imageName: String
    let emotionName: String
    let level: Double

    var body: some View {
        HStack(spacing: 12) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 46, height: 46)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.green.opacity(0.2), lineWidth: 1))

            VStack(alignment: .leading, spacing: 6) {
                Text(emotionName)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.black.opacity(0.85))
                ProgressView(value: level)
                    .tint(.green)
            }
            Spacer()
            Text(String(format: "%.0f%%", level * 100))
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(.secondary)
        }
        .padding(14)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.green.opacity(0.12), lineWidth: 1)
        )
    }
}

#Preview {
    HomeView(currentUserId: "test_user_123")
}
