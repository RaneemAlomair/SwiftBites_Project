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
  @State private var vm: IngredientsViewModel? = nil

  init(selection: Selection? = nil) { self.selection = selection }

  var body: some View {
    NavigationStack {
      Group {
        if (vm?.ingredients.isEmpty ?? true) {
          ContentUnavailableView(
            label: { Label("No Ingredients", systemImage: "list.clipboard") },
            description: { Text("Ingredients you add will appear here.") },
            actions: {
              NavigationLink("Add Ingredient", value: IngredientFormViewModel.Mode.add)
                .buttonStyle(.borderedProminent)
            }
          )
        } else {
          List {
            if (vm?.ingredients.isEmpty ?? true) {
              ContentUnavailableView(label: { Text("Couldn't find \"\(vm?.search ?? "")\"") })
                .listRowSeparator(.hidden)
            } else {
              ForEach(vm!.ingredients) { ing in
                row(for: ing)
                  .swipeActions {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                      vm?.delete(ing)
                    }
                  }
              }
            }
          }
          .listStyle(.plain)
          .searchable(text: Binding(
            get: { vm?.search ?? "" },
            set: { vm?.search = $0; vm?.reload() }
          ))
        }
      }
      .navigationTitle("Ingredients")
      .toolbar {
        if !(vm?.ingredients.isEmpty ?? true) {
          NavigationLink(value: IngredientFormViewModel.Mode.add) { Label("Add", systemImage: "plus") }
        }
      }
      .navigationDestination(for: IngredientFormViewModel.Mode.self) { IngredientFormView(mode: $0) }
    }
    .onAppear {
      if vm == nil { vm = IngredientsViewModel(context: context) }
    }
  }

  @ViewBuilder
  private func row(for ing: Ingredient) -> some View {
    if let selection {
      Button(ing.name) { selection(ing) }
    } else {
      NavigationLink(value: IngredientFormViewModel.Mode.edit(ing)) {
        Text(ing.name).font(.title3)
      }
    }
  }
}
