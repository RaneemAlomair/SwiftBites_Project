//
//  CategoryFormView.swift
//  SwiftBites
//
//  Created by Raneem Alomair on 26/10/2025.
//

import SwiftUI
import SwiftData
import Observation

struct CategoryFormView: View {
  let mode: CategoryFormViewModel.Mode
  @Environment(\.modelContext) private var context
  @State private var vm: CategoryFormViewModel? = nil

  var body: some View {
    Group {
      if let vm {
        CategoryFormScreen(vm: vm, mode: mode)
      } else {
        ProgressView()
          .task { vm = CategoryFormViewModel(context: context, mode: mode) }
      }
    }
  }
}

private struct CategoryFormScreen: View {
  @Bindable var vm: CategoryFormViewModel
  let mode: CategoryFormViewModel.Mode
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    Form {
      Section { TextField("Name", text: $vm.name) }
      if case .edit(let c) = mode {
        Button(role: .destructive) { vm.delete(c); dismiss() } label: {
          Text("Delete Category").frame(maxWidth: .infinity)
        }
      }
    }
    .navigationTitle(vm.title)
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button("Save") { vm.save(mode: mode); dismiss() }
          .disabled(vm.name.isEmpty)
      }
    }
  }
}
