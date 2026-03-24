import SwiftUI

struct EmotionDetailView: View {
    let emotion: EmotionModel

    var body: some View {
        ZStack {
            // Fondo general
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

            ScrollView {
                VStack {

                    
                    ZStack(alignment: .topTrailing) {

                        RoundedRectangle(cornerRadius: 28, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color.white,
                                        Color.green.opacity(0.05)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )

                        // decoraciones
                        Circle()
                            .fill(Color.green.opacity(0.10))
                            .frame(width: 140, height: 140)
                            .offset(x: 50, y: -50)

                        Circle()
                            .fill(Color.green.opacity(0.05))
                            .frame(width: 90, height: 90)
                            .offset(x: 20, y: 20)

                        // 👇 TODO el contenido aquí dentro
                        VStack(spacing: 20) {

                            Text(emotion.emoji)
                                .font(.system(size: 80))

                            Text(emotion.name)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundStyle(Color.black.opacity(0.85))

                            VStack(alignment: .leading, spacing: 8) {
                                Text("Descripción")
                                    .font(.system(size: 16, weight: .semibold))

                                Text(emotion.description)
                                    .font(.system(size: 15))
                                    .foregroundStyle(Color.black.opacity(0.7))
                                    .lineSpacing(4)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)

                        }
                        .padding(24)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 28, style: .continuous)
                            .stroke(Color.green.opacity(0.18), lineWidth: 1)
                    )
                    .shadow(color: Color.green.opacity(0.10), radius: 14, x: 0, y: 8)
                    .padding()

                }
            }
        }
        .navigationTitle(emotion.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        EmotionDetailView(emotion: EmotionModel.all[0])
    }
}
