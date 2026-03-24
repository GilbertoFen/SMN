import SwiftUI

struct textFieldOnboarding: View
{
    var text: String = ""
    var isSelected: Bool = false
    var action: () -> Void = {}

    var body: some View
    {
        Button(action: action)
        {
            HStack
            {
                Text(text)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(isSelected ? .white : Color.black.opacity(0.75))
                    .padding(.leading, 24)

                Spacer()

                if isSelected
                {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.white)
                        .font(.system(size: 20))
                        .padding(.trailing, 20)
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .frame(maxWidth: 350, minHeight: 60)
            .background(
                isSelected
                    ? Color(red: 0.2, green: 0.6, blue: 0.4)
                    : Color.gray.opacity(0.12)
            )
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(
                        isSelected
                            ? Color(red: 0.2, green: 0.6, blue: 0.4)
                            : Color.gray.opacity(0.25),
                        lineWidth: 1.5
                    )
            )
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
        }
        .buttonStyle(.plain)
    }
}

#Preview
{
    VStack(spacing: 12)
    {
        textFieldOnboarding(text: "Ansiedad", isSelected: false)
        textFieldOnboarding(text: "Depresión", isSelected: true)
        textFieldOnboarding(text: "Relaciones", isSelected: false)
        textFieldOnboarding(text: "Autoestima", isSelected: false)
    }
    .padding()
}
