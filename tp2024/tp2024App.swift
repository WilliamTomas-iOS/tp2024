//
//  tp2024App.swift
//  tp2024
//
//  Created by William Tomas on 04/03/2024.
//

import SwiftUI
import SwiftData

@main
struct tp2024App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Subscription.self)
    }
}
