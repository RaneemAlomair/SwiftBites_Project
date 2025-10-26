//
//  RecipeFormView.swift
//  SwiftBites
//
//  Created by Raneem Alomair on 26/10/2025.
//

import SwiftUI
import SwiftData
import PhotosUI
import Observation

struct RecipeFormView: View {
  typealias Mode = RecipeFormViewModel.Mode
  let mode: Mode

  @Environment(\.modelContext) private var context
  @State private var vm: RecipeFormViewModel? = nil

  var body: some View {
    Group {
      if let vm {
        RecipeFormScreen(vm: vm, mode: mode)
      } else {
        ProgressView()
          .task { vm = RecipeFormViewModel(context: context, mode: mode) }
      }
    }
  }
}

// Inner
private struct RecipeFormScreen: View {
  @Bindable var vm: RecipeFormViewModel
  let mode: RecipeFormViewModel.Mode

  @Environment(\.dismiss) private var dismiss
  @State private var photoItem: PhotosPickerItem?

  var body: some View {
    GeometryReader { geo in
      Form {
        Section { imagePicker(width: geo.size.width); removeImage }
        Section("Name") { TextField("Margherita Pizza", text: $vm.name) }
        Section("Summary") {
          TextField("Delicious blend...", text: $vm.summary, axis: .vertical).lineLimit(3...5)
        }
        Section { categoryPicker }
        Section {
          Stepper("Servings: \(vm.serving)p", value: $vm.serving, in: 1...100)
          Stepper("Time: \(vm.time)m", value: $vm.time, in: 5...300, step: 5)
        }.monospacedDigit()
        ingredientsSection
        Section("Instructions") {
          TextField("1. Preheat...\n2. ...", text: $vm.instructions, axis: .vertical).lineLimit(8...12)
        }
        deleteButton
      }
    }
    .navigationTitle(vm.title)
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button("Save") { vm.save(mode: mode); dismiss() }
          .disabled(vm.name.isEmpty || vm.instructions.isEmpty)
      }
    }
    .onChange(of: photoItem) { _, _ in
      Task { vm.imageData = try? await photoItem?.loadTransferable(type: Data.self) }
    }
  }

  // MARK: - Subviews
  private var categoryPicker: some View {
    Picker("Category", selection: Binding<Category?>(
      get: { vm.category }, set: { vm.category = $0 }
    )) {
      Text("None").tag(nil as Category?)
      ForEach(vm.categories) { Text($0.name).tag(Optional($0)) }
    }
  }

  private var ingredientsSection: some View {
    Section("Ingredients") {
      if vm.items.isEmpty {
        ContentUnavailableView(
          label: { Label("No Ingredients", systemImage: "list.clipboard") },
          description: { Text("Recipe ingredients will appear here.") },
          actions: { NavigationLink("Add Ingredient", destination: ingredientPickerView) }
        )
      } else {
        ForEach(vm.items) { item in
          HStack {
            Text(item.ingredient.name).bold().layoutPriority(2)
            Spacer()
            TextField("Quantity", text: Binding(
              get: { item.quantity },
              set: { q in if let i = vm.items.firstIndex(where: { $0.id == item.id }) { vm.items[i].quantity = q } }
            ))
          }
        }
        .onDelete(perform: vm.deleteIngredients)
        NavigationLink("Add Ingredient", destination: ingredientPickerView)
      }
    }
  }

  private var ingredientPickerView: some View {
    List(vm.allIngredients) { ing in
      Button(ing.name) { vm.addIngredient(ing) }
    }
    .navigationTitle("Add Ingredient")
  }

  @ViewBuilder private func imagePicker(width: CGFloat) -> some View {
    PhotosPicker(selection: $photoItem, matching: .images) {
      if let data = vm.imageData, let ui = UIImage(data: data) {
        Image(uiImage: ui).resizable().scaledToFill()
          .frame(width: width).clipped()
          .listRowInsets(EdgeInsets())
          .frame(maxWidth: .infinity, minHeight: 200, idealHeight: 200, maxHeight: 200)
      } else { Label("Select Image", systemImage: "photo") }
    }
  }

  @ViewBuilder private var removeImage: some View {
    if vm.imageData != nil {
      Button(role: .destructive) { vm.imageData = nil } label: {
        Text("Remove Image").frame(maxWidth: .infinity)
      }
    }
  }

  @ViewBuilder private var deleteButton: some View {
    if case .edit(let r) = mode {
      Button(role: .destructive) { vm.delete(recipe: r); dismiss() } label: {
        Text("Delete Recipe").frame(maxWidth: .infinity)
      }
    }
  }
}
