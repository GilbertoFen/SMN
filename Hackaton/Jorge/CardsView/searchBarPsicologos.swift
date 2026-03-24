import SwiftUI

struct searchBarPsicologos: View
{
    @State var searchText: String = ""
    
    var body: some View
    {
        ZStack(alignment: .trailing)
        {
            HStack(spacing: 10)
            {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
                
                TextField("Buscar", text: $searchText)
                    .font(.subheadline)
            }
            .padding(.leading, 16)
            .padding(.trailing, 90)
            .frame(height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.gray.opacity(1.9), lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .shadow(color: .black.opacity(0.08), radius: 10, y: 4)
            
            
            HStack(spacing: 12)
            {
                Button {} label:
                {
                    Image(systemName: "microphone.fill")
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                }
                
                Button {} label:
                {
                    Image(systemName: "keyboard.fill")
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                }
            }
            .padding(.horizontal, 10)
            .frame(height: 32)
            .background(Color.black)
            .clipShape(Capsule())
            .padding(.trailing, 10)
        }
        .padding(.horizontal)
    }
}

#Preview
{
    searchBarPsicologos()
}
