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
  @State private var vm: RecipesViewModel? = nil

  var body: some View {
    NavigationStack {
      Group {
        if (vm?.recipes.isEmpty ?? true) {
          ContentUnavailableView(
            label: { Label("No Recipes", systemImage: "list.clipboard") },
            description: { Text("Recipes you add will appear here.") },
            actions: {
              NavigationLink("Add Recipe", value: RecipeFormViewModel.Mode.add)
                .buttonStyle(.borderedProminent)
            }
          )
        } else {
          ScrollView {
            LazyVStack(spacing: 10) {
              ForEach(vm!.recipes) { RecipeCell(recipe: $0) }
            }
          }
          .searchable(text: Binding(
            get: { vm?.search ?? "" },
            set: { vm?.search = $0; vm?.reload() }
          ))
        }
      }
      .navigationTitle("Recipes")
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Menu("Sort", systemImage: "arrow.up.arrow.down") {
            Button("Name") { vm?.sort = .name; vm?.reload() }
            Button("Serving (low to high)") { vm?.sort = .servingAsc; vm?.reload() }
            Button("Serving (high to low)") { vm?.sort = .servingDesc; vm?.reload() }
            Button("Time (short to long)") { vm?.sort = .timeAsc; vm?.reload() }
            Button("Time (long to short)") { vm?.sort = .timeDesc; vm?.reload() }
          }
        }
        ToolbarItem(placement: .topBarTrailing) {
          NavigationLink(value: RecipeFormViewModel.Mode.add) { Label("Add", systemImage: "plus") }
        }
      }
      .navigationDestination(for: RecipeFormViewModel.Mode.self) { RecipeFormView(mode: $0) }     
    }
    .onAppear { if vm == nil { vm = RecipesViewModel(context: context) } }
  }
}
