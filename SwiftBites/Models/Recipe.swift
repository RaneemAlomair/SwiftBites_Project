//
//  Recipe.swift
//  SwiftBites
//
//  Created by Raneem Alomair on 26/10/2025.
//

// FILE: Models/Recipe.swift
import Foundation
import SwiftData

@Model
final class Recipe: Identifiable {
  @Attribute(.unique) var name: String
  var summary: String
  @Relationship var category: Category?
  var serving: Int
  var time: Int            // minutes
  @Relationship(deleteRule: .cascade) var ingredients: [RecipeIngredient]
  var instructions: String
  var imageData: Data?

  init(
    id: UUID = UUID(),
    name: String,
    summary: String = "",
    category: Category? = nil,
    serving: Int = 1,
    time: Int = 5,
    ingredients: [RecipeIngredient] = [],
    instructions: String = "",
    imageData: Data? = nil
  ) {
    self.name = name
    self.summary = summary
    self.category = category
    self.serving = serving
    self.time = time
    self.ingredients = ingredients
    self.instructions = instructions
    self.imageData = imageData
  }
}
