//  DrishyaApp.swift
//  Drishya
//  Created by UDIT PANDEY on 28/09/26.

import SwiftUI
import SwiftData

@main
struct DrishyaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Title.self)
    }
}
