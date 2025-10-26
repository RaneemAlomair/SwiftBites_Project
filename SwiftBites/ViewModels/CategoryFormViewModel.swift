//
//  CategoryFormViewModel.swift
//  SwiftBites
//
//  Created by Raneem Alomair on 26/10/2025.
//

import Foundation
import SwiftData
import Observation

@MainActor
@Observable
final class CategoryFormViewModel {
  private let context: ModelContext
  var title: String
  var name: String

  init(context: ModelContext, mode: Mode) {
    self.context = context
    switch mode {
    case .add:
      title = "Add Category"; name = ""
    case .edit(let c):
      title = "Edit \(c.name)"; name = c.name
    }
  }

  enum Mode: Hashable { case add, edit(Category) }

  func save(mode: Mode) {
    switch mode {
    case .add: context.insert(Category(name: name))
    case .edit(let c): c.name = name
    }
    try? context.save()
  }

  func delete(_ c: Category) {
    context.delete(c)
    try? context.save()
  }
}
