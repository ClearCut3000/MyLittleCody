//
//  Task.swift
//  MyLittleCody
//
//  Created by Николай Никитин on 26.02.2024.
//

import Foundation

enum TaskCategory: String, Codable {
  case leetCode
  case yandexContest
  case yandexCodeRun
  // Другие категории
}

enum TaskDifficulty: String, Codable {
  case easy
  case medium
  case hard
  // Другие уровни сложности
}

struct Task: Codable {
  let id: Int
  let title: String
  let category: TaskCategory
  let difficulty: TaskDifficulty
  let description: String
  let solution: String
  let link: String
}
