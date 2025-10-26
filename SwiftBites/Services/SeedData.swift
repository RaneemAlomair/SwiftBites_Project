//
//  SeedData.swift
//  SwiftBites
//
//  Created by Raneem Alomair on 26/10/2025.
//

import SwiftUI
import SwiftData

enum SeedData {
  @AppStorage("didSeedSwiftBites") private static var didSeed = false

  @MainActor
  static func run(using context: ModelContext) async {
    guard !didSeed else { return }

    // Ingredients
    let pizzaDough = Ingredient(name: "Pizza Dough")
    let tomatoSauce = Ingredient(name: "Tomato Sauce")
    let mozzarella = Ingredient(name: "Mozzarella Cheese")
    let basil = Ingredient(name: "Fresh Basil Leaves")
    let evoo = Ingredient(name: "Extra Virgin Olive Oil")
    let salt = Ingredient(name: "Salt")
    let spaghetti = Ingredient(name: "Spaghetti")
    let eggs = Ingredient(name: "Eggs")
    let parmesan = Ingredient(name: "Parmesan Cheese")
    let pancetta = Ingredient(name: "Pancetta")
    [pizzaDough, tomatoSauce, mozzarella, basil, evoo, salt, spaghetti, eggs, parmesan, pancetta].forEach { context.insert($0) }

    // Category
    let italian = Category(name: "Italian")
    context.insert(italian)
      
    let middleEastern = Category(name: "Middle Eastern")
      context.insert(middleEastern)

    // Recipes
    let margherita = Recipe(
      name: "Classic Margherita Pizza",
      summary: "A simple yet delicious pizza with tomato, mozzarella, basil, and olive oil.",
      category: italian,
      serving: 4,
      time: 50,
      ingredients: [
        RecipeIngredient(ingredient: pizzaDough, quantity: "1 ball"),
        RecipeIngredient(ingredient: tomatoSauce, quantity: "1/2 cup"),
        RecipeIngredient(ingredient: mozzarella, quantity: "1 cup, shredded"),
        RecipeIngredient(ingredient: basil, quantity: "A handful"),
        RecipeIngredient(ingredient: evoo, quantity: "2 tbsp"),
        RecipeIngredient(ingredient: salt, quantity: "Pinch"),
      ],
      instructions: "Preheat oven, roll out dough, apply sauce, add cheese and basil, bake for ~20 minutes."
    )
    context.insert(margherita)

    let carbonara = Recipe(
      name: "Spaghetti Carbonara",
      summary: "A classic Italian pasta with eggs, cheese, pancetta, and pepper.",
      category: italian,
      serving: 4,
      time: 30,
      ingredients: [
        RecipeIngredient(ingredient: spaghetti, quantity: "400g"),
        RecipeIngredient(ingredient: eggs, quantity: "4"),
        RecipeIngredient(ingredient: parmesan, quantity: "1 cup, grated"),
        RecipeIngredient(ingredient: pancetta, quantity: "200g, diced"),
      ],
      instructions: "Cook spaghetti. Fry pancetta. Mix eggs + Parmesan off-heat with pasta. Season."
    )
    context.insert(carbonara)

    try? context.save()
    didSeed = true
  }
}
