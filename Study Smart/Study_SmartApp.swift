//
//  Study_SmartApp.swift
//  Study Smart
//
//  Created by mehreen sajid on 1/31/24.
//

import SwiftUI

@main
struct Study_SmartApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
