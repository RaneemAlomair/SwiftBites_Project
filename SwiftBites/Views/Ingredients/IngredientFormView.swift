//
//  IngredientFormView.swift
//  SwiftBites
//
//  Created by Raneem Alomair on 26/10/2025.
//

import SwiftUI
import SwiftData
import Observation

struct IngredientFormView: View {
  let mode: IngredientFormViewModel.Mode

  @Environment(\.modelContext) private var context
  @State private var vm: IngredientFormViewModel? = nil

  var body: some View {
    Group {
      if let vm {
        IngredientFormScreen(vm: vm, mode: mode)
      } else {
        ProgressView()
          .task {
            vm = IngredientFormViewModel(context: context, mode: mode)
          }
      }
    }
  }
}

private struct IngredientFormScreen: View {
  @Bindable var vm: IngredientFormViewModel
  let mode: IngredientFormViewModel.Mode

  @Environment(\.dismiss) private var dismiss

  var body: some View {
    Form {
      Section {
        TextField("Name", text: $vm.name)  
      }

      if case .edit(let i) = mode {
        Button(role: .destructive) {
          vm.delete(i)
          dismiss()
        } label: {
          Text("Delete Ingredient").frame(maxWidth: .infinity)
        }
      }
    }
    .navigationTitle(vm.title)
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button("Save") {
          vm.save(mode: mode)
          dismiss()
        }
        .disabled(vm.name.isEmpty)
      }
    }
  }
}
