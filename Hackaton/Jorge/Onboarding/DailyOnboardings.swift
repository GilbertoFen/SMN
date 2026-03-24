import SwiftUI

struct CheckInPregunta
{
    let titulo: String
    let subtitulo: String
    let opciones: [CheckInOpcion]
}

struct CheckInOpcion: Identifiable, Equatable
{
    let id = UUID()
    let imagen: Image
    let texto: String
    let valor: Int

    static func == (lhs: CheckInOpcion, rhs: CheckInOpcion) -> Bool
    {
        lhs.id == rhs.id
    }
}



struct CheckInBoton: View
{
    let opcion: CheckInOpcion
    let isSelected: Bool
    let action: () -> Void

    var body: some View
    {
        Button(action: action)
        {
            HStack(spacing: 14)
            {
                opcion.imagen
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26, height: 26)
                    .padding(5)
                    .background(
                        Circle()
                            .fill(
                                isSelected
                                ? Color(red: 0.2, green: 0.6, blue: 0.4).opacity(0.15)
                                : Color.gray.opacity(0.07)
                            )
                    )

                Text(opcion.texto)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(
                        isSelected
                        ? Color(red: 0.1, green: 0.45, blue: 0.3)
                        : Color.black.opacity(0.75)
                    )
                    .multilineTextAlignment(.leading)

                Spacer(minLength: 8)

                if isSelected
                {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(Color(red: 0.2, green: 0.6, blue: 0.4))
                        .font(.system(size: 18))
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 13)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(
                        isSelected
                        ? Color(red: 0.2, green: 0.6, blue: 0.4).opacity(0.08)
                        : Color.white
                    )
                    .shadow(
                        color: isSelected
                        ? Color(red: 0.2, green: 0.6, blue: 0.4).opacity(0.2)
                        : Color.black.opacity(0.06),
                        radius: isSelected ? 8 : 4,
                        x: 0,
                        y: 2
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(
                        isSelected
                        ? Color(red: 0.2, green: 0.6, blue: 0.4).opacity(0.4)
                        : Color.gray.opacity(0.12),
                        lineWidth: 1.2
                    )
            )
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isSelected)
        }
        .buttonStyle(.plain)
    }
}



struct CheckInResumen: View
{
    let respuestas: [String: CheckInOpcion]
    let onTerminar: () -> Void

    var body: some View
    {
        ScrollView
        {
            VStack(spacing: 24)
            {
                ZStack
                {
                    Circle()
                        .fill(Color(red: 0.2, green: 0.6, blue: 0.4).opacity(0.12))
                        .frame(width: 100, height: 100)

                    Image("poñoñonfeli")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipped()
                }
                .padding(.top, 24)

                VStack(spacing: 8)
                {
                    Text("¡Gracias por tu check-in!")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(Color.black.opacity(0.85))

                    Text("Registraste cómo te sientes hoy.\nVuelve mañana para seguir tu progreso.")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }

                VStack(spacing: 10)
                {
                    ForEach(Array(respuestas.keys.sorted()), id: \.self) { key in
                        if let opcion = respuestas[key]
                        {
                            HStack(alignment: .center, spacing: 12)
                            {
                                opcion.imagen
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 22, height: 22)

                                Text(key)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundStyle(Color.gray)
                                    .multilineTextAlignment(.leading)

                                Spacer(minLength: 8)

                                Text(opcion.texto)
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundStyle(Color(red: 0.1, green: 0.45, blue: 0.3))
                                    .multilineTextAlignment(.trailing)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(red: 0.2, green: 0.6, blue: 0.4).opacity(0.06))
                            )
                        }
                    }
                }
                .padding(.horizontal, 28)

                Button(action: onTerminar)
                {
                    Text("Volver al inicio")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color(red: 0.2, green: 0.6, blue: 0.4))
                        )
                }
                .padding(.horizontal, 28)
                .padding(.top, 8)
                .padding(.bottom, 24)
            }
            .frame(maxWidth: .infinity)
        }
        .scrollIndicators(.hidden)
    }
}



struct DailyCheckIn: View
{
    // ← Nuevo: callback externo opcional
    var onTerminar: () -> Void = {}

    @State private var preguntaActual = 0
    @State private var respuestas: [String: CheckInOpcion] = [:]
    @State private var terminado = false

    let accentGreen = Color(red: 0.2, green: 0.6, blue: 0.4)

    let preguntas: [CheckInPregunta] =
    [
        CheckInPregunta(
            titulo: "¿Cómo te sientes hoy?",
            subtitulo: "Tu estado emocional general",
            opciones: [
                CheckInOpcion(imagen: Image(systemName: "face.smiling.fill"), texto: "Muy bien, con energía", valor: 5),
                CheckInOpcion(imagen: Image(systemName: "face.smiling"), texto: "Bien, tranquilo/a", valor: 4),
                CheckInOpcion(imagen: Image(systemName: "face.dashed"), texto: "Regular, ni bien ni mal", valor: 3),
                CheckInOpcion(imagen: Image(systemName: "cloud.drizzle.fill"), texto: "Un poco bajo/a de ánimo", valor: 2),
                CheckInOpcion(imagen: Image(systemName: "cloud.heavyrain.fill"), texto: "Mal, me cuesta el día", valor: 1)
            ]
        ),
        CheckInPregunta(
            titulo: "¿Cómo dormiste anoche?",
            subtitulo: "El sueño afecta mucho tu bienestar",
            opciones: [
                CheckInOpcion(imagen: Image(systemName: "moon.stars.fill"), texto: "Muy bien, descansé profundo", valor: 5),
                CheckInOpcion(imagen: Image(systemName: "moon.fill"), texto: "Bien, con alguna interrupción", valor: 4),
                CheckInOpcion(imagen: Image(systemName: "moon"), texto: "Regular, no fue suficiente", valor: 3),
                CheckInOpcion(imagen: Image(systemName: "zzz"), texto: "Mal, me costó dormir", valor: 2),
                CheckInOpcion(imagen: Image(systemName: "exclamationmark.triangle.fill"), texto: "No dormí casi nada", valor: 1)
            ]
        ),
        CheckInPregunta(
            titulo: "¿Cómo está tu ansiedad?",
            subtitulo: "Reconocer la ansiedad es el primer paso",
            opciones: [
                CheckInOpcion(imagen: Image(systemName: "leaf.fill"), texto: "Calmado/a, sin tensión", valor: 5),
                CheckInOpcion(imagen: Image(systemName: "wind"), texto: "Leve inquietud, manejable", valor: 4),
                CheckInOpcion(imagen: Image(systemName: "bolt.fill"), texto: "Algo tenso/a hoy", valor: 3),
                CheckInOpcion(imagen: Image(systemName: "bolt.trianglebadge.exclamationmark.fill"), texto: "Bastante ansioso/a", valor: 2),
                CheckInOpcion(imagen: Image(systemName: "hurricane"), texto: "Muy agobiado/a", valor: 1)
            ]
        ),
        CheckInPregunta(
            titulo: "¿Cómo te hablas a ti mismo/a?",
            subtitulo: "Tu diálogo interno importa",
            opciones: [
                CheckInOpcion(imagen: Image(systemName: "heart.fill"), texto: "Con amabilidad y apoyo", valor: 5),
                CheckInOpcion(imagen: Image(systemName: "heart"), texto: "Bastante bien, con calma", valor: 4),
                CheckInOpcion(imagen: Image(systemName: "minus.circle"), texto: "A veces me exijo demasiado", valor: 3),
                CheckInOpcion(imagen: Image(systemName: "arrow.down.heart"), texto: "Con bastante autocrítica", valor: 2),
                CheckInOpcion(imagen: Image(systemName: "heart.slash.fill"), texto: "Muy duro/a conmigo mismo/a", valor: 1)
            ]
        ),
        CheckInPregunta(
            titulo: "¿Te sientes conectado/a hoy?",
            subtitulo: "El apoyo social nutre tu salud mental",
            opciones: [
                CheckInOpcion(imagen: Image(systemName: "person.2.fill"), texto: "Sí, bien acompañado/a", valor: 5),
                CheckInOpcion(imagen: Image(systemName: "person.fill"), texto: "Un poco, tengo a alguien", valor: 4),
                CheckInOpcion(imagen: Image(systemName: "person"), texto: "Neutral", valor: 3),
                CheckInOpcion(imagen: Image(systemName: "person.fill.questionmark"), texto: "Me siento algo aislado/a", valor: 2),
                CheckInOpcion(imagen: Image(systemName: "person.slash.fill"), texto: "Bastante solo/a hoy", valor: 1)
            ]
        )
    ]

    var body: some View
    {
        ZStack
        {
            Color.white
                .ignoresSafeArea()

            fondoDecorativo

            if terminado
            {
                CheckInResumen(respuestas: respuestas, onTerminar: onTerminar)
                    .transition(.opacity.combined(with: .move(edge: .trailing)))
            }
            else
            {
                ScrollView
                {
                    contenidoPrincipal
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 30)
                }
                .scrollIndicators(.hidden)
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.35), value: terminado)
    }

    private var fondoDecorativo: some View
    {
        ZStack
        {
            Circle()
                .fill(accentGreen.opacity(0.15))
                .frame(width: 260, height: 220)
                .offset(x: 130, y: -290)

            Circle()
                .fill(accentGreen.opacity(0.28))
                .frame(width: 340, height: 340)
                .offset(x: 170, y: -330)

            Circle()
                .fill(accentGreen.opacity(0.25))
                .frame(width: 220, height: 220)
                .offset(x: -150, y: 360)
        }
        .ignoresSafeArea()
    }

    private var contenidoPrincipal: some View
    {
        VStack(spacing: 0)
        {
            Image(systemName: "heart.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(accentGreen.opacity(0.35))
                .padding(.top, 24)
                .padding(.bottom, 12)

            VStack(spacing: 4)
            {
                Text("Check-in diario")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(accentGreen)
                    .textCase(.uppercase)
                    .tracking(1.2)

                Text(fechaHoy())
                    .font(.system(size: 15))
                    .foregroundStyle(Color.gray.opacity(0.7))
            }
            .padding(.bottom, 22)

            HStack(spacing: 8)
            {
                ForEach(0..<preguntas.count, id: \.self) { i in
                    Capsule()
                        .fill(i <= preguntaActual ? accentGreen : Color.gray.opacity(0.25))
                        .frame(width: i == preguntaActual ? 28 : 8, height: 8)
                        .animation(.spring(response: 0.3), value: preguntaActual)
                }
            }
            .padding(.bottom, 28)

            preguntaView(preguntas[preguntaActual])
                .id(preguntaActual)
                .padding(.horizontal, 24)

            Spacer(minLength: 20)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 4)
        .padding(.vertical, 12)
    }

    @ViewBuilder
    private func preguntaView(_ pregunta: CheckInPregunta) -> some View
    {
        VStack(spacing: 10)
        {
            Text(pregunta.subtitulo)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(accentGreen.opacity(0.8))
                .textCase(.uppercase)
                .tracking(0.8)

            Text(pregunta.titulo)
                .font(.system(size: 21, weight: .bold))
                .foregroundStyle(Color.black.opacity(0.85))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 12)
                .padding(.bottom, 8)

            ForEach(pregunta.opciones) { opcion in
                CheckInBoton(
                    opcion: opcion,
                    isSelected: respuestas[pregunta.titulo] == opcion
                )
                {
                    respuestas[pregunta.titulo] = opcion

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35)
                    {
                        withAnimation(.easeInOut(duration: 0.4))
                        {
                            if preguntaActual < preguntas.count - 1
                            {
                                preguntaActual += 1
                            }
                            else
                            {
                                terminado = true
                            }
                        }
                    }
                }
            }
        }
        .transition(
            .asymmetric(
                insertion: .opacity.combined(with: .move(edge: .trailing)),
                removal: .opacity.combined(with: .move(edge: .leading))
            )
        )
    }

    func fechaHoy() -> String
    {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_MX")
        formatter.dateFormat = "EEEE, d 'de' MMMM"
        return formatter.string(from: Date()).capitalized
    }
}

#Preview
{
    DailyCheckIn()
}
