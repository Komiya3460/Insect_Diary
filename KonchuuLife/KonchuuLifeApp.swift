//
//  KonchuuLifeApp.swift
//  KonchuuLife
//
//  Created by 越智三四郎 on 2024/09/22.
//

import SwiftUI
import Firebase

@main
struct KonchuuLifeApp: App {
    init() {
            FirebaseApp.configure()
        }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
