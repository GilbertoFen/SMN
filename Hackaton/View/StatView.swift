import SwiftUI
import Charts

struct StatsView: View {
    let currentUserId: String

    @StateObject var statViewModel: StatViewModel

    init(currentUserId: String) {
        self.currentUserId = currentUserId
        _statViewModel = StateObject(wrappedValue: StatViewModel(userId: currentUserId))
    }

    private let accentGreen = Color(red: 0.2, green: 0.6, blue: 0.4)

    static let emotionColors: [String: Color] = [
        "Feliz":    Color(red: 0.95, green: 0.75, blue: 0.10),
        "Triste":   Color(red: 0.22, green: 0.48, blue: 0.85),
        "Enojado":  Color(red: 0.85, green: 0.22, blue: 0.22),
        "Ansiedad": Color(red: 0.95, green: 0.50, blue: 0.10),
        "Miedo":    Color(red: 0.52, green: 0.30, blue: 0.85),
    ]

    var selectedColor: Color {
        Self.emotionColors[statViewModel.selectedEmotion] ?? accentGreen
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(statViewModel.emotions, id: \.self) { emotion in
                                let isSelected = statViewModel.selectedEmotion == emotion
                                let color = Self.emotionColors[emotion] ?? accentGreen
                                Button(action: {
                                    statViewModel.selectedEmotion = emotion
                                }) {
                                    Text(emotion)
                                        .font(.system(size: 13, weight: isSelected ? .medium : .regular))
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 9)
                                        .background(isSelected ? color : Color(.secondarySystemBackground))
                                        .foregroundStyle(isSelected ? .white : Color.primary)
                                        .clipShape(Capsule())
                                        .overlay(
                                            Capsule()
                                                .stroke(
                                                    isSelected ? Color.clear : Color.black.opacity(0.07),
                                                    lineWidth: 0.5
                                                )
                                        )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                    }

                    if statViewModel.filteredStats.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .font(.system(size: 36))
                                .foregroundStyle(selectedColor.opacity(0.4))
                            Text("Sin datos")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(Color.black.opacity(0.7))
                            Text("No hay registros para esta emoción en los últimos 30 días.")
                                .font(.system(size: 13))
                                .foregroundStyle(Color.black.opacity(0.4))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 32)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 260)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal)
                    } else {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 6) {
                                Circle()
                                    .fill(selectedColor)
                                    .frame(width: 8, height: 8)
                                Text(statViewModel.selectedEmotion)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundStyle(Color.black.opacity(0.6))
                            }

                            Chart(statViewModel.filteredStats) { stat in
                                LineMark(
                                    x: .value("Día", stat.date),
                                    y: .value("Rating", stat.rating)
                                )
                                .foregroundStyle(selectedColor)
                                .interpolationMethod(.catmullRom)
                                .lineStyle(StrokeStyle(lineWidth: 2))

                                AreaMark(
                                    x: .value("Día", stat.date),
                                    y: .value("Rating", stat.rating)
                                )
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [selectedColor.opacity(0.18), selectedColor.opacity(0.0)],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .interpolationMethod(.catmullRom)

                                PointMark(
                                    x: .value("Día", stat.date),
                                    y: .value("Rating", stat.rating)
                                )
                                .foregroundStyle(selectedColor)
                                .symbolSize(30)
                            }
                            .chartYScale(domain: 1...10)
                            .chartXAxis {
                                AxisMarks(values: .automatic(desiredCount: 6)) { _ in
                                    AxisValueLabel(format: .dateTime.month().day(), centered: true)
                                        .font(.system(size: 10))
                                    AxisGridLine()
                                        .foregroundStyle(Color.black.opacity(0.06))
                                }
                            }
                            .chartYAxis {
                                AxisMarks(values: [1, 3, 5, 7, 10]) { _ in
                                    AxisValueLabel()
                                        .font(.system(size: 10))
                                    AxisGridLine()
                                        .foregroundStyle(Color.black.opacity(0.06))
                                }
                            }
                            .frame(height: 260)
                        }
                        .padding(16)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            HStack(spacing: 6) {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(accentGreen)
                                    .font(.system(size: 13))
                                Text("Notas destacadas")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundStyle(Color.black.opacity(0.85))
                            }
                            Spacer()
                            Text("\(statViewModel.relevantNotes.count)")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(Color.black.opacity(0.35))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Color(.secondarySystemBackground))
                                .clipShape(Capsule())
                        }
                        .padding(.horizontal)

                        if statViewModel.relevantNotes.isEmpty {
                            VStack(spacing: 10) {
                                Image(systemName: "note.text")
                                    .font(.system(size: 34))
                                    .foregroundStyle(accentGreen.opacity(0.35))
                                Text("Aún no tienes notas destacadas")
                                    .font(.system(size: 14))
                                    .foregroundStyle(Color.black.opacity(0.4))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 36)
                            .background(Color(.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.horizontal)
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 14) {
                                    ForEach(statViewModel.relevantNotes) { note in
                                        NoteCardView(note: note)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                            }
                        }
                    }
                    .padding(.bottom, 12)
                }
                .padding(.top)
            }
            .navigationTitle("Estadísticas")
            .onAppear {
                statViewModel.getStats()
                statViewModel.getNotes()
            }
        }
    }
}

#Preview {
    StatsView(currentUserId: "test_user_123")
}
