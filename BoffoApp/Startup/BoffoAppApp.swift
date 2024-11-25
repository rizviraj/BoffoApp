//
//  BoffoAppApp.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import SwiftUI

@main
struct BoffoAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    //let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            //ContentView()
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
