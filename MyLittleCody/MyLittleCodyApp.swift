//
//  MyLittleCodyApp.swift
//  MyLittleCody
//
//  Created by Николай Никитин on 25.02.2024.
//

import SwiftUI

@main
struct MyLittleCodyApp: App {

  let appStateManager = AppStateManager()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(appStateManager)
    }
  }
}
