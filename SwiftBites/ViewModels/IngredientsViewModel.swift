//
//  IngredientsViewModel.swift
//  SwiftBites
//
//  Created by Raneem Alomair on 26/10/2025.
//

import Foundation
import SwiftData
import Observation

@MainActor
@Observable
 class IngredientsViewModel {
  private let context: ModelContext
  var search = ""
  var ingredients: [Ingredient] = []

  init(context: ModelContext) {
    self.context = context
    reload()
  }

  func reload() {
    var d = FetchDescriptor<Ingredient>(sortBy: [.init(\.name)])
    if !search.isEmpty { d.predicate = #Predicate { $0.name.localizedStandardContains(search) } }
    ingredients = (try? context.fetch(d)) ?? []
  }

  func delete(_ ing: Ingredient) {
    context.delete(ing)
    try? context.save()
    reload()
  }
}
