//
//  RecipeIngredient.swift
//  SwiftBites
//
//  Created by Raneem Alomair on 26/10/2025.
//

import Foundation
import SwiftData

@Model
final class RecipeIngredient: Identifiable {
  var id: UUID
  @Relationship var ingredient: Ingredient
  var quantity: String

  init(id: UUID = UUID(), ingredient: Ingredient, quantity: String = "") {
    self.id = id
    self.ingredient = ingredient
    self.quantity = quantity
  }
}
