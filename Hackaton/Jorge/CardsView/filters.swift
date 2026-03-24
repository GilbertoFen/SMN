import SwiftUI

struct filters: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(Color.primary.opacity(0.8))
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Capsule()
                    .fill(Color.white.opacity(0.9))
                    .background(.ultraThinMaterial)
            )
            .overlay(
                Capsule()
                    .stroke(Color.black.opacity(0.15), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.05), radius: 6, y: 3)
    }
}

#Preview {
    filters(text: "#Sexo")
}
