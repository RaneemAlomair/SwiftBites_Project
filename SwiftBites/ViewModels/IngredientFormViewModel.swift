//
//  IngredientFormViewModel.swift
//  SwiftBites
//
//  Created by Raneem Alomair on 26/10/2025.
//

import Foundation
import SwiftData
import Observation

@MainActor
@Observable
final class IngredientFormViewModel {
  private let context: ModelContext
  var title: String
  var name: String

  init(context: ModelContext, mode: Mode) {
    self.context = context
    switch mode {
    case .add: title = "Add Ingredient"; name = ""
    case .edit(let i): title = "Edit \(i.name)"; name = i.name
    }
  }

  enum Mode: Hashable { case add, edit(Ingredient) }

  func save(mode: Mode) {
    switch mode {
    case .add: context.insert(Ingredient(name: name))
    case .edit(let i): i.name = name
    }
    try? context.save()
  }

  func delete(_ i: Ingredient) {
    context.delete(i)
    try? context.save()
  }
}

