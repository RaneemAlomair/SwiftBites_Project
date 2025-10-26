//
//  RecipeFormViewModel.swift
//  SwiftBites
//
//  Created by Raneem Alomair on 26/10/2025.
//

import Foundation
import SwiftData
import Observation

@MainActor
@Observable
final class RecipeFormViewModel {
  private let context: ModelContext

  // form fields
  var title: String
  var name: String
  var summary: String
  var serving: Int
  var time: Int
  var instructions: String
  var category: Category?
  var items: [RecipeIngredient]
  var imageData: Data?

  // lists
  var categories: [Category] = []
  var allIngredients: [Ingredient] = []

  init(context: ModelContext, mode: Mode) {
    self.context = context
    switch mode {
    case .add:
      self.title = "Add Recipe"
      self.name = ""
      self.summary = ""
      self.serving = 1
      self.time = 5
      self.instructions = ""
      self.category = nil
      self.items = []
      self.imageData = nil
    case .edit(let r):
      self.title = "Edit \(r.name)"
      self.name = r.name
      self.summary = r.summary
      self.serving = r.serving
      self.time = r.time
      self.instructions = r.instructions
      self.category = r.category
      self.items = r.ingredients
      self.imageData = r.imageData
    }
    loadPickers()
  }

  func loadPickers() {
    categories = (try? context.fetch(FetchDescriptor<Category>(sortBy: [.init(\.name)]))) ?? []
    allIngredients = (try? context.fetch(FetchDescriptor<Ingredient>(sortBy: [.init(\.name)]))) ?? []
  }

  enum Mode: Hashable { case add, edit(Recipe) }

  func addIngredient(_ ing: Ingredient) {
    items.append(RecipeIngredient(ingredient: ing))
  }

  func deleteIngredients(at offsets: IndexSet) {
    items.remove(atOffsets: offsets)
  }

  func save(mode: Mode) {
    switch mode {
    case .add:
      let recipe = Recipe(
        name: name, summary: summary, category: category,
        serving: serving, time: time, ingredients: items,
        instructions: instructions, imageData: imageData
      )
      context.insert(recipe)
    case .edit(let r):
      r.name = name
      r.summary = summary
      r.category = category
      r.serving = serving
      r.time = time
      r.ingredients = items
      r.instructions = instructions
      r.imageData = imageData
    }
    try? context.save()
  }

  func delete(recipe: Recipe) {
    context.delete(recipe)
    try? context.save()
  }
}

