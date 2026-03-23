//
//  HackatonApp.swift
//  Hackaton
//
//  Created by Annete Morado on 23/03/26.
//

import SwiftUI

@main
struct HackatonApp: App {
    // Crea una única instancia de ModelData para toda la app
    @State private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
    }
}
