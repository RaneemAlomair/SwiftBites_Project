//
//  Category.swift
//  SwiftBites
//
//  Created by Raneem Alomair on 26/10/2025.
//

// FILE: Models/Category.swift
import Foundation
import SwiftData

@Model
final class Category: Identifiable {
  @Attribute(.unique) var id: UUID
  @Attribute(.unique) var name: String
  @Relationship(deleteRule: .cascade, inverse: \Recipe.category) var recipes: [Recipe]

  init(id: UUID = UUID(), name: String) {
    self.id = id
    self.name = name
    self.recipes = []
  }
}
