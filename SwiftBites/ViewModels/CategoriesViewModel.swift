//
//  CategoriesViewModel.swift
//  SwiftBites
//
//  Created by Raneem Alomair on 26/10/2025.
//

import Foundation
import SwiftData
import Observation

@MainActor
@Observable
final class CategoriesViewModel {
  private let context: ModelContext
  var search = ""
  var categories: [Category] = []

  init(context: ModelContext) {
    self.context = context
    reload()
  }

  func reload() {
    var d = FetchDescriptor<Category>(sortBy: [.init(\.name)])
    if !search.isEmpty {
      d.predicate = #Predicate { $0.name.localizedStandardContains(search) }
    }
    categories = (try? context.fetch(d)) ?? []
  }
}
