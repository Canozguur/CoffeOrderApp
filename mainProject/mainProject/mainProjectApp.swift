//
//  mainProjectApp.swift
//  mainProject
//
//  Created by Can Özgür on 2.05.2024.
//

import SwiftUI

@main
struct mainProjectApp: App {
    @StateObject var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                
        }
    }
}
