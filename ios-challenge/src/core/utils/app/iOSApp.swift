//
//  iOSApp.swift
//  ios-challenge
//
//  Created by Marc Flores on 10/4/24.
//

import SwiftUI
import SwiftData

@main
struct iOSApp: App {
    
    var sharedModelContainer: ModelContainer = {
        do {
            let schema = Schema([
                Asset.self,
                Transaction.self
            ])
            
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .modelContainer(sharedModelContainer)
        }
    }
}
