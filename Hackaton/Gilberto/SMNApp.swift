//
//  SMNApp.swift
//  SMN
//
//  Created by Gil Avalos on 23/03/26.
//

import SwiftUI
import SwiftData

struct SMNApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            SMNItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView().environment(ModelData())
        }
        .modelContainer(sharedModelContainer)
    }
}
