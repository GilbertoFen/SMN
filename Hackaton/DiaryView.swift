//
//  DiaryView.swift
//  Hackaton
//
//  Created by Annete Morado on 23/03/26.
//

import SwiftUI
import Charts



struct DiaryView: View {
    @Environment(ModelData.self) var modelData
    var graphics: [Graphic]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Diario")
                .font(.title2)
                .bold()

            Chart(graphics) {
                LineMark(
                    x: .value("Day", $0.date),
                    y: .value("Scale", $0.score)
                )
                .foregroundStyle(by: .value("Emotion", $0.emotion))
            }
            .frame(width: 200, height: 200)
        }
        .padding()
    }
}

#Preview {
    let modelData = ModelData()
    
    DiaryView(graphics: modelData.graphics)
        .environment(modelData)
}
