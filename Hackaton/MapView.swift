import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var psycologistViewModel: PsycologistViewModel
    @State private var position: MapCameraPosition = .automatic

    var body: some View {
        Map(position: $position) {
            ForEach(psycologistViewModel.psycologists) { psycologist in
                Marker(psycologist.name, coordinate: psycologist.coordinate)
                    .tint(.indigo)
            }
        }
        .mapStyle(.standard)         // Normal (default)
        .mapStyle(.hybrid)           // Satélite + calles
        .mapStyle(.imagery)
        .onAppear {
            centerMapIfNeeded()
        }
        .onChange(of: psycologistViewModel.psycologists) { _, psycologists in
            centerMapIfNeeded()
        }
    }

    private func centerMapIfNeeded() {
        guard let first = psycologistViewModel.psycologists.first else { return }
        withAnimation {
            position = .region(MKCoordinateRegion(
                center: first.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            ))
        }
    }
}

#Preview {
    MapView(psycologistViewModel: PsycologistViewModel())
}
