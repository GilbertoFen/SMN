import SwiftUI

struct Onboarding0: View
{
    var onNext: () -> Void = {}

    var body: some View
    {
        GeometryReader { geo in
            ZStack
            {
                Rectangle()
                    .fill(.white)

                Circle()
                    .fill(.green.opacity(0.2))
                    .frame(width: 500, height: 1000)
                    .offset(x: 0, y: -500)

                Circle()
                    .fill(.green.opacity(0.2))
                    .frame(width: 600, height: 1000)
                    .offset(x: 0, y: -400)

                Circle()
                    .fill(.green.opacity(0.3))
                    .frame(width: 700, height: 1000)
                    .offset(x: 0, y: -300)

                Image("image1")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 200, maxHeight: 350)
                    .offset(x: 0, y: -geo.size.height * 0.20)

                
                Circle()
                    .fill(.green.opacity(0.2))
                    .frame(width: 600, height: 300)
                    .offset(x: 200, y: 450)

                Circle()
                    .fill(.green.opacity(0.15))
                    .frame(width: 700, height: 300)
                    .offset(x: 200, y: 500)

                
                
                
                
                VStack(spacing: 6)
                {
                    Text("Ayúdanos a")
                        .font(.system(size: 28, weight: .light))
                        .foregroundStyle(Color.black.opacity(0.5))

                    Text("conocerte mejor")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(Color.black.opacity(0.85))
                }
                .multilineTextAlignment(.center)
                .offset(x: 0, y: geo.size.height * 0.12)

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
                .offset(x: 0, y: geo.size.height * 0.30)
                .buttonStyle(.plain)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview
{
    Onboarding0()
}
