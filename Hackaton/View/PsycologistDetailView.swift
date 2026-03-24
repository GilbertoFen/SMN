import SwiftUI
import MapKit

struct PsycologistDetailView: View {
    let psycologist: PsycologistModel
    @StateObject var viewModel: PsycologistDetailViewModel = PsycologistDetailViewModel()

    @State private var selectedDate: Date = Date()
    @State private var selectedHour: String = "09:00"
    @State private var showBookingConfirmation: Bool = false
    @State private var newComment: String = ""
    @State private var newRating: Int = 5

    let availableHours = ["09:00", "10:00", "11:00", "12:00", "13:00", "16:00", "17:00", "18:00"]

    private let accentGreen = Color(red: 0.2, green: 0.6, blue: 0.4)
    private let lightGreen  = Color(red: 0.2, green: 0.6, blue: 0.4).opacity(0.12)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // ── HEADER: mapa + avatar ──────────────────────────────
                ZStack(alignment: .bottomLeading) {
                    Map(position: .constant(.region(MKCoordinateRegion(
                        center: psycologist.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    )))) {
                        Marker(psycologist.name, coordinate: psycologist.coordinate)
                            .tint(accentGreen)
                    }
                    .frame(maxWidth: .infinity, minHeight: 190)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .disabled(true)

                    Circle()
                        .fill(lightGreen)
                        .frame(width: 82, height: 82)
                        .overlay {
                            Image(psycologist.photoName)
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                        }
                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                        .offset(x: 20, y: 36)
                }
                .padding(.bottom, 36)

                // ── NOMBRE Y ESPECIALIDAD ──────────────────────────────
                VStack(alignment: .leading, spacing: 4) {
                    Text(psycologist.name)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(Color.black.opacity(0.85))

                    Text(psycologist.speciality)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(Color.black.opacity(0.45))

                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                            .font(.system(size: 12))
                        Text(String(format: "%.1f", viewModel.averageRating))
                            .font(.system(size: 12))
                            .foregroundStyle(Color.black.opacity(0.45))
                    }
                }
                .padding(.horizontal, 4)

                // ── INFORMACIÓN ────────────────────────────────────────
                VStack(alignment: .leading, spacing: 14) {
                    SectionHeader(title: "Información")

                    InfoRow(icon: "person.fill",        label: "Edad",       value: "\(psycologist.age) años")
                    InfoRow(icon: "dollarsign.circle.fill", label: "Precio",  value: "$\(Int(psycologist.price)) MXN")

                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "video.fill")
                            .foregroundStyle(accentGreen)
                            .frame(width: 18)
                        Text("Modalidad")
                            .font(.system(size: 13))
                            .foregroundStyle(Color.black.opacity(0.45))
                            .frame(width: 80, alignment: .leading)
                        HStack(spacing: 6) {
                            ForEach(psycologist.mode, id: \.self) { m in
                                Text(m.capitalized)
                                    .font(.system(size: 11, weight: .medium))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .background(Color(red: 0.91, green: 0.95, blue: 0.87))
                                    .foregroundStyle(Color(red: 0.15, green: 0.31, blue: 0.04))
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    .font(.system(size: 13))

                    InfoRow(icon: "text.alignleft", label: "Descripción", value: psycologist.description)
                }
                .padding(16)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20))

                // ── AGENDAR CITA ───────────────────────────────────────
                VStack(alignment: .leading, spacing: 14) {
                    SectionHeader(title: "Agendar cita")

                    DatePicker(
                        "Selecciona una fecha",
                        selection: $selectedDate,
                        in: Date()...,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.graphical)
                    .tint(accentGreen)
                    .padding(12)
                    .background(Color(.tertiarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    Text("Selecciona una hora")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.black.opacity(0.45))

                    LazyVGrid(
                        columns: Array(repeating: GridItem(.flexible()), count: 4),
                        spacing: 10
                    ) {
                        ForEach(availableHours, id: \.self) { hour in
                            Button(action: { selectedHour = hour }) {
                                Text(hour)
                                    .font(.system(size: 13, weight: selectedHour == hour ? .medium : .regular))
                                    .padding(.vertical, 9)
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        selectedHour == hour
                                            ? accentGreen
                                            : Color(.tertiarySystemBackground)
                                    )
                                    .foregroundStyle(selectedHour == hour ? .white : Color.primary)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(
                                                selectedHour == hour
                                                    ? Color.clear
                                                    : Color.black.opacity(0.08),
                                                lineWidth: 0.5
                                            )
                                    )
                            }
                            .buttonStyle(.plain)
                        }
                    }

                    Button(action: {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd"
                        let dateString = formatter.string(from: selectedDate)
                        viewModel.bookAppointment(
                            psycologistId: psycologist.id ?? "",
                            date: dateString,
                            hour: selectedHour
                        )
                        showBookingConfirmation = true
                    }) {
                        Text("Confirmar cita")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(accentGreen)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .shadow(color: accentGreen.opacity(0.25), radius: 8, y: 4)
                    }
                    .buttonStyle(.plain)
                    .alert("¡Cita agendada!", isPresented: $showBookingConfirmation) {
                        Button("OK", role: .cancel) {}
                    } message: {
                        Text("Tu cita con \(psycologist.name) a las \(selectedHour) ha sido confirmada.")
                    }
                }
                .padding(16)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20))

                // ── COMENTARIOS ────────────────────────────────────────
                VStack(alignment: .leading, spacing: 14) {
                    SectionHeader(title: "Comentarios (\(viewModel.comments.count))")

                    // Input nuevo comentario
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Deja tu opinión")
                            .font(.system(size: 13))
                            .foregroundStyle(Color.black.opacity(0.45))

                        HStack(spacing: 6) {
                            ForEach(1...5, id: \.self) { star in
                                Image(systemName: star <= newRating ? "star.fill" : "star")
                                    .foregroundStyle(.yellow)
                                    .font(.system(size: 20))
                                    .onTapGesture { newRating = star }
                            }
                        }

                        TextField("Escribe tu comentario...", text: $newComment, axis: .vertical)
                            .lineLimit(3...5)
                            .font(.system(size: 14))
                            .padding(12)
                            .background(Color(.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 12))

                        Button(action: {
                            guard !newComment.isEmpty else { return }
                            viewModel.addComment(
                                psycologistId: psycologist.id ?? "",
                                comment: newComment,
                                rating: newRating
                            )
                            newComment = ""
                            newRating = 5
                        }) {
                            Text("Publicar")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 22)
                                .padding(.vertical, 9)
                                .background(accentGreen)
                                .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(14)
                    .background(Color(.tertiarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    // Lista de comentarios
                    ForEach(viewModel.comments) { comment in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                HStack(spacing: 3) {
                                    ForEach(1...5, id: \.self) { star in
                                        Image(systemName: star <= comment.rating ? "star.fill" : "star")
                                            .foregroundStyle(.yellow)
                                            .font(.system(size: 11))
                                    }
                                }
                                Spacer()
                                Text(comment.id_user)
                                    .font(.system(size: 11))
                                    .foregroundStyle(Color.black.opacity(0.35))
                            }
                            Text(comment.comment)
                                .font(.system(size: 14))
                                .foregroundStyle(Color.black.opacity(0.8))
                        }
                        .padding(14)
                        .background(Color(.tertiarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.black.opacity(0.06), lineWidth: 0.5)
                        )
                    }
                }
                .padding(16)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding(16)
        }
        .navigationTitle(psycologist.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.getComments(psycologistId: psycologist.id ?? "")
        }
    }
}

// ── SUBVISTAS ──────────────────────────────────────────────────────────────

private struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.system(size: 15, weight: .semibold))
            .foregroundStyle(Color.black.opacity(0.75))
    }
}

struct InfoRow: View {
    let icon: String
    let label: String
    let value: String

    private let accentGreen = Color(red: 0.2, green: 0.6, blue: 0.4)

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: icon)
                .foregroundStyle(accentGreen)
                .frame(width: 18)
            Text(label)
                .foregroundStyle(Color.black.opacity(0.45))
                .frame(width: 80, alignment: .leading)
            Text(value)
                .foregroundStyle(Color.black.opacity(0.8))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .font(.system(size: 13))
    }
}

#Preview {
    NavigationStack {
        PsycologistDetailView(psycologist: PsycologistModel(
            name: "Dra. Laura Sánchez",
            age: 35,
            latitude: 19.4326,
            longitude: -99.1332,
            mode: ["online", "presencial"],
            price: 800.0,
            speciality: "Ansiedad",
            rating: 3,
            description: "Especialista en manejo de ansiedad con 10 años de experiencia.",
            photoName: "placeholder"
        ))
    }
}
