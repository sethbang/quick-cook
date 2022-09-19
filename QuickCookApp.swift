//
//  QuickCookApp.swift
//  QuickCook
//
//  Created by Seth Bangert on 9/19/22.
//

import SwiftUI

@main
struct QuickCookApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
