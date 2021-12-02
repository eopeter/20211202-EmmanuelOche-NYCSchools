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
    let schoolsApi = SchoolsApi()
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: .init(schoolsApiService: schoolsApi)
            )
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
