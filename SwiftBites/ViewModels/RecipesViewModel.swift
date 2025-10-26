//
//  RecipesViewModel.swift
//  SwiftBites
//
//  Created by Raneem Alomair on 26/10/2025.
//

import Foundation
import SwiftData
import Observation

@MainActor
@Observable
final class RecipesViewModel {
  enum SortKey { case name, servingAsc, servingDesc, timeAsc, timeDesc }

  private let context: ModelContext
  var search = ""
  var sort: SortKey = .name
  var recipes: [Recipe] = []

  init(context: ModelContext) {
    self.context = context
    reload()
  }

  func reload() {
    var descriptor = FetchDescriptor<Recipe>()
    switch sort {
    case .name: descriptor.sortBy = [.init(\.name, order: .forward)]
    case .servingAsc: descriptor.sortBy = [.init(\.serving, order: .forward)]
    case .servingDesc: descriptor.sortBy = [.init(\.serving, order: .reverse)]
    case .timeAsc: descriptor.sortBy = [.init(\.time, order: .forward)]
    case .timeDesc: descriptor.sortBy = [.init(\.time, order: .reverse)]
    }
    if !search.isEmpty {
      descriptor.predicate = #Predicate { r in
        r.name.localizedStandardContains(search) || r.summary.localizedStandardContains(search)
      }
    }
    recipes = (try? context.fetch(descriptor)) ?? []
  }

  func delete(_ recipe: Recipe) {
    context.delete(recipe)
    try? context.save()
    reload()
  }
}
