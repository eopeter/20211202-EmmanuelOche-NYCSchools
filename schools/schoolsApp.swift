//
//  schoolsApp.swift
//  schools
//
//  Created by Emmanuel Oche on 12/1/21.
//

import SwiftUI

@main
struct schoolsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
