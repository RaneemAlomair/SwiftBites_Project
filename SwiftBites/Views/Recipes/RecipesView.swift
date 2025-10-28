//
//  RecipesView.swift
//  SwiftBites
//
//  Created by Raneem Alomair on 26/10/2025.
//

import SwiftUI
import SwiftData

struct RecipesView: View {
  @Environment(\.modelContext) private var context

  @Query private var liveRecipes: [Recipe]

  @State private var search = ""
  @State private var sortKey: SortKey = .name

  enum SortKey { case name, servingAsc, servingDesc, timeAsc, timeDesc }

  private var filtered: [Recipe] {
    var out = liveRecipes
    if !search.isEmpty {
      out = out.filter { $0.name.localizedStandardContains(search) || $0.summary.localizedStandardContains(search) }
    }
    switch sortKey {
      case .name: out = out.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
      case .servingAsc: out = out.sorted { $0.serving < $1.serving }
      case .servingDesc: out = out.sorted { $0.serving > $1.serving }
      case .timeAsc: out = out.sorted { $0.time < $1.time }
      case .timeDesc: out = out.sorted { $0.time > $1.time }
    }
    return out
  }

  var body: some View {
    NavigationStack {
      Group {
        if liveRecipes.isEmpty {
          ContentUnavailableView(
            label: { Label("No Recipes", systemImage: "list.clipboard") },
            description: { Text("Recipes you add will appear here.") },
            actions: { NavigationLink("Add Recipe", value: RecipeFormViewModel.Mode.add).buttonStyle(.borderedProminent) }
          )
        } else {
          ScrollView {
            if filtered.isEmpty {
              ContentUnavailableView(label: { Text("Couldn't find \"\(search)\"") })
            } else {
              LazyVStack(spacing: 10) { ForEach(filtered) { RecipeCell(recipe: $0) } }
            }
          }
          .searchable(text: $search)
        }
      }
      .navigationTitle("Recipes")
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Menu("Sort", systemImage: "arrow.up.arrow.down") {
            Button("Name") { sortKey = .name }
            Button("Serving (low to high)") { sortKey = .servingAsc }
            Button("Serving (high to low)") { sortKey = .servingDesc }
            Button("Time (short to long)") { sortKey = .timeAsc }
            Button("Time (long to short)") { sortKey = .timeDesc }
          }
        }
        ToolbarItem(placement: .topBarTrailing) {
          NavigationLink(value: RecipeFormViewModel.Mode.add) { Label("Add", systemImage: "plus") }
        }
      }
      .navigationDestination(for: RecipeFormViewModel.Mode.self) { RecipeFormView(mode: $0) }
    }
  }
}
