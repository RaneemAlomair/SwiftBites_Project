//
//  Ingredient.swift
//  SwiftBites
//
//  Created by Raneem Alomair on 26/10/2025.
//

import Foundation
import SwiftData

@Model
final class Ingredient: Identifiable {
  @Attribute(.unique) var name: String
  init(id: UUID = UUID(), name: String) { self.name = name }
}

