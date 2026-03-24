import SwiftUI

struct PreguntaData
{
    let titulo: String
    let opciones: [String]
}

struct Onboarding: View
{
    var onNext: () -> Void = {}
    @State private var preguntaActual = 0
    @State private var respuestas: [String: String] = [:]

    let preguntas: [PreguntaData] =
    [
        PreguntaData(titulo: "¿Por qué buscas ayuda?",       opciones: ["Ansiedad", "Depresión", "Relaciones", "Autoestima"]),
        PreguntaData(titulo: "¿Has tenido terapia antes?",   opciones: ["Sí, recientemente", "Sí, hace tiempo", "Nunca"]),
        PreguntaData(titulo: "¿Cómo prefieres tu sesión?",   opciones: ["En línea", "Presencial", "Me da igual"]),
        PreguntaData(titulo: "¿Cuándo tienes disponibilidad?", opciones: ["Mañana", "Tarde", "Noche"])
    ]

    var body: some View
    {
        GeometryReader { geo in
            ZStack
            {
                Rectangle()
                    .fill(.white)

                
                Circle()
                    .fill(.green.opacity(0.2))
                    .frame(width: 400, height: 500)
                    .offset(x: 100, y: -250)

                Circle()
                    .fill(.green.opacity(0.25))
                    .frame(width: 600, height: 1000)
                    .offset(x: 100, y: -250)

                Circle()
                    .fill(.green.opacity(0.15))
                    .frame(width: 800, height: 100)
                    .offset(x: 100, y: -250)

                Image("image2")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 200, maxHeight: 350)
                    .offset(x: 0, y: -geo.size.height * 0.19)

                HStack(spacing: 8)
                {
                    ForEach(0..<preguntas.count, id: \.self) { i in
                        Capsule()
                            .fill(i == preguntaActual
                                  ? Color(red: 0.2, green: 0.6, blue: 0.4)
                                  : Color.gray.opacity(0.25))
                            .frame(width: i == preguntaActual ? 24 : 8, height: 8)
                            .animation(.spring(response: 0.3), value: preguntaActual)
                    }
                }
                .offset(x: 0, y: -geo.size.height * 0.08)

                ForEach(0..<preguntas.count, id: \.self) { i in
                    if preguntaActual == i
                    {
                        VStack(spacing: 12)
                        {
                            Text(preguntas[i].titulo)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(Color.black.opacity(0.85))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 32)
                                .padding(.bottom, 8)

                            ForEach(preguntas[i].opciones, id: \.self) { opcion in
                                textFieldOnboarding(
                                    text: opcion,
                                    isSelected: respuestas[preguntas[i].titulo] == opcion
                                )
                                {
                                    respuestas[preguntas[i].titulo] = opcion

                                    guard i < preguntas.count - 1 else { return }

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35)
                                    {
                                        withAnimation(.easeInOut(duration: 0.4))
                                        {
                                            preguntaActual += 1
                                        }
                                    }
                                }
                            }
                        }
                        .transition(.asymmetric(
                            insertion: .opacity.combined(with: .move(edge: .trailing)),
                            removal:   .opacity.combined(with: .move(edge: .leading))
                        ))
                        .offset(x: 0, y: geo.size.height * 0.19)
                    }
                }

                if preguntaActual == preguntas.count - 1,
                   respuestas[preguntas[preguntaActual].titulo] != nil
                {
                    Button(action: onNext)
                    {
                        Image(systemName: "arrow.right")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(width: 68, height: 68)
                            .background(Color(red: 0.2, green: 0.6, blue: 0.4))
                            .clipShape(Circle())
                            .shadow(color: .green.opacity(0.3), radius: 10, y: 4)
                    }
                    .offset(x: 0, y: geo.size.height * 0.4)
                    .buttonStyle(.plain)
                    .transition(.opacity.combined(with: .scale))
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview
{
    Onboarding()
}
