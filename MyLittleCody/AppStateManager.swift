//
//  AppStateManager.swift
//  MyLittleCody
//
//  Created by Николай Никитин on 26.02.2024.
//

import SwiftUI

class AppStateManager: ObservableObject {
  enum AppState {
    case home
    case taskDetail(task: Task)
    // Другие состояния, если необходимо
  }

  @Published var state: AppState = .home
  let dataManager = DataManager.shared

  func showTaskDetail(_ task: Task) {
    state = .taskDetail(task: task)
  }

  func showHome() {
    state = .home
  }
}
