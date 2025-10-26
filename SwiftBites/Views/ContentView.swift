//
//  ContentView.swift
//  SwiftBites
//
//  Created by Raneem Alomair on 26/10/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) private var context

  var body: some View {
    TabView {
      RecipesView()
        .tabItem { Label("Recipes", systemImage: "frying.pan") }

      CategoriesView()
        .tabItem { Label("Categories", systemImage: "tag") }

      IngredientsView()
        .tabItem { Label("Ingredients", systemImage: "carrot") }
    }
    .task { await SeedData.run(using: context) }
  }
}

