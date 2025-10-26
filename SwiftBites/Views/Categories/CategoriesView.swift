//
//  CategoriesView.swift
//  SwiftBites
//
//  Created by Raneem Alomair on 26/10/2025.
//

import SwiftUI
import SwiftData

struct CategoriesView: View {
  @Environment(\.modelContext) private var context
  @State private var vm: CategoriesViewModel? = nil

  var body: some View {
    NavigationStack {
      Group {
        if (vm?.categories.isEmpty ?? true) {
          ContentUnavailableView(
            label: { Label("No Categories", systemImage: "list.clipboard") },
            description: { Text("Categories you add will appear here.") },
            actions: {
              NavigationLink("Add Category", value: CategoryFormViewModel.Mode.add)
                .buttonStyle(.borderedProminent)
            }
          )
        } else {
          ScrollView {
            if (vm?.categories.isEmpty ?? true) {
              ContentUnavailableView(label: { Text("Couldn't find \"\(vm?.search ?? "")\"") })
            } else {
              LazyVStack(spacing: 10) {
                ForEach(vm!.categories, content: CategorySection.init)
              }
            }
          }
          .searchable(text: Binding(
            get: { vm?.search ?? "" },
            set: { vm?.search = $0; vm?.reload() }
          ))
        }
      }
      .navigationTitle("Categories")
      .toolbar {
        if !(vm?.categories.isEmpty ?? true) {
          NavigationLink(value: CategoryFormViewModel.Mode.add) {
            Label("Add", systemImage: "plus")
          }
        }
      }
      .navigationDestination(for: CategoryFormViewModel.Mode.self) {
        CategoryFormView(mode: $0)
      }
      .navigationDestination(for: RecipeFormView.Mode.self) {       
        RecipeFormView(mode: $0)
      }
    }
    .onAppear { if vm == nil { vm = CategoriesViewModel(context: context) } }
  }
}
