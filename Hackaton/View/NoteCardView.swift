//
//  NoteCardView.swift
//  Hackaton
//

import SwiftUI

struct NoteCardView: View {
    let note: NoteModel

    private let brandGreen = Color(red: 0.2, green: 0.6, blue: 0.4)

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            // Rating badge
            HStack {
                Spacer()
                Text(String(format: "%.0f%%", note.rating * 100))
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(brandGreen)
                    .clipShape(Capsule())
            }

            // Contenido
            Text(note.content)
                .font(.system(size: 13, weight: .light))
                .foregroundStyle(Color.black.opacity(0.55))
                .lineLimit(3)
                .multilineTextAlignment(.leading)

            Spacer()

            // Fecha
            HStack {
                Image(systemName: "calendar")
                    .font(.system(size: 10))
                    .foregroundStyle(brandGreen.opacity(0.7))
                Text(note.date)
                    .font(.system(size: 11, weight: .light))
                    .foregroundStyle(Color.black.opacity(0.35))
            }
        }
        .padding(16)
        .frame(width: 200, height: 170)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: brandGreen.opacity(0.12), radius: 10, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(brandGreen.opacity(0.15), lineWidth: 1)
        )
    }
}

#Preview {
    NoteCardView(note: NoteModel(
        content: "Esta es una nota de prueba con contenido relevante para mostrar el diseño de la tarjeta.",
        date: "2026-03-24",
        id_user: "test_user_123",
        rating: 0.8
    ))
    .padding()
}
