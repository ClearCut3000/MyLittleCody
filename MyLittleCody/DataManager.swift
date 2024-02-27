//
//  DataManager.swift
//  MyLittleCody
//
//  Created by Николай Никитин on 26.02.2024.
//

import Foundation

class DataManager {
  static let shared = DataManager()

  private var tasks: [Task] = []

  private init() {
    loadTasksFromLibrary()
  }
  
  private func loadTasksFromLibrary() {
    guard let url = Bundle.main.url(forResource: "Library", withExtension: "json") else {
      fatalError("Unable to locate Library.json")
    }

    do {
      let data = try Data(contentsOf: url)
      let decoder = JSONDecoder()
      tasks = try decoder.decode([Task].self, from: data)
    } catch {
      fatalError("Error decoding Library.json: \(error)")
    }
  }

  func getAllTasks() -> [Task] {
    return tasks
  }

  func getTasks(byCategory category: TaskCategory) -> [Task] {
    return tasks.filter { $0.category == category }
  }

  func getTasks(byDifficulty difficulty: TaskDifficulty) -> [Task] {
    return tasks.filter { $0.difficulty == difficulty }
  }
}
