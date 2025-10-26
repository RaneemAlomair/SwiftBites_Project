//
//  Ingredient.swift
//  SwiftBites
//
//  Created by Raneem Alomair on 26/10/2025.
//

// FILE: Models/Ingredient.swift
import Foundation
import SwiftData

@Model
final class Ingredient: Identifiable {
  @Attribute(.unique) var id: UUID
  @Attribute(.unique) var name: String
  init(id: UUID = UUID(), name: String) { self.id = id; self.name = name }
}
