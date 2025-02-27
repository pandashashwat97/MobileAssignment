//
//  AssignmentApp.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI
import SwiftData

@main
struct AssignmentApp: App {

    
    private var container: ModelContainer {
        try! ModelContainer(for: DeviceSwiftData.self)
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
