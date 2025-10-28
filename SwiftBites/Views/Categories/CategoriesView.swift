//
//  CategoriesView.swift
//  SwiftBites
//
//  Created by Raneem Alomair on 26/10/2025.
//

import SwiftUI
import SwiftData

struct CategoriesView: View {
  @Query(sort: [SortDescriptor<Category>(\.name)]) private var liveCategories: [Category]
  @State private var search = ""

  private var filtered: [Category] {
    guard !search.isEmpty else { return liveCategories }
    return liveCategories.filter { $0.name.localizedStandardContains(search) }
  }

  var body: some View {
    NavigationStack {
      Group {
        if liveCategories.isEmpty {
          ContentUnavailableView(
            label: { Label("No Categories", systemImage: "list.clipboard") },
            description: { Text("Categories you add will appear here.") },
            actions: { NavigationLink("Add Category", value: CategoryFormViewModel.Mode.add).buttonStyle(.borderedProminent) }
          )
        } else {
          ScrollView {
            if filtered.isEmpty {
              ContentUnavailableView(label: { Text("Couldn't find \"\(search)\"") })
            } else {
              LazyVStack(spacing: 10) { ForEach(filtered, content: CategorySection.init) }
            }
          }
          .searchable(text: $search)
        }
      }
      .navigationTitle("Categories")
      .toolbar {
        if !liveCategories.isEmpty {
          NavigationLink(value: CategoryFormViewModel.Mode.add) { Label("Add", systemImage: "plus") }
        }
      }
      .navigationDestination(for: CategoryFormViewModel.Mode.self) { CategoryFormView(mode: $0) }
      .navigationDestination(for: RecipeFormViewModel.Mode.self) { RecipeFormView(mode: $0) }
    }
  }
}
