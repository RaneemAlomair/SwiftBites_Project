//
//  IngredientsView.swift
//  SwiftBites
//
//  Created by Raneem Alomair on 26/10/2025.
//

import SwiftUI
import SwiftData

struct IngredientsView: View {
  typealias Selection = (Ingredient) -> Void
  let selection: Selection?

  @Environment(\.modelContext) private var context
  @Query(sort: [SortDescriptor<Ingredient>(\.name)]) private var liveIngredients: [Ingredient]
  @State private var search = ""

  init(selection: Selection? = nil) { self.selection = selection }

  private var filtered: [Ingredient] {
    guard !search.isEmpty else { return liveIngredients }
    return liveIngredients.filter { $0.name.localizedStandardContains(search) }
  }

  var body: some View {
    NavigationStack {
      Group {
        if liveIngredients.isEmpty {
          ContentUnavailableView(
            label: { Label("No Ingredients", systemImage: "list.clipboard") },
            description: { Text("Ingredients you add will appear here.") },
            actions: { NavigationLink("Add Ingredient", value: IngredientFormViewModel.Mode.add).buttonStyle(.borderedProminent) }
          )
        } else {
          List {
            if filtered.isEmpty {
              ContentUnavailableView(label: { Text("Couldn't find \"\(search)\"") })
                .listRowSeparator(.hidden)
            } else {
              ForEach(filtered) { ing in
                row(for: ing)
                  .swipeActions {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                      context.delete(ing); try? context.save()
                    }
                  }
              }
            }
          }
          .listStyle(.plain)
          .searchable(text: $search)
        }
      }
      .navigationTitle("Ingredients")
      .toolbar {
        if !liveIngredients.isEmpty {
          NavigationLink(value: IngredientFormViewModel.Mode.add) { Label("Add", systemImage: "plus") }
        }
      }
      .navigationDestination(for: IngredientFormViewModel.Mode.self) { IngredientFormView(mode: $0) }
    }
  }

  @ViewBuilder
  private func row(for ing: Ingredient) -> some View {
    if let selection {
      Button(ing.name) { selection(ing) }
    } else {
      NavigationLink(value: IngredientFormViewModel.Mode.edit(ing)) { Text(ing.name).font(.title3) }
    }
  }
}
