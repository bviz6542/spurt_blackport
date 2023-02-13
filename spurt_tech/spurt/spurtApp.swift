//
//  spurtApp.swift
//  spurt
//
//  Created by 정준우 on 2022/11/25.
//

import SwiftUI

@main
struct spurtApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView{
                Way()
                //NewDrawingScreen()
                //ImageCanvas()
                //ImageVC()
                    .navigationBarTitleDisplayMode(.inline)
            }.navigationViewStyle(.stack)
            //ttt()
            //ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
