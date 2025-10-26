//
//  RecipeCell.swift
//  SwiftBites
//
//  Created by Raneem Alomair on 26/10/2025.
//

import SwiftUI

struct RecipeCell: View {
  let recipe: Recipe

  var body: some View {
    NavigationLink(value: RecipeFormView.Mode.edit(recipe)) {
      VStack(alignment: .leading, spacing: 10) {
        image
        labels
      }
      .padding(.horizontal)
    }
    .buttonStyle(.plain)
  }

  private var image: some View {
    innerImage
      .resizable()
      .scaledToFill()
      .frame(maxHeight: 150)
      .clipShape(RoundedRectangle(cornerRadius: 10))
  }

  private var innerImage: Image {
    if let data = recipe.imageData, let ui = UIImage(data: data) { return Image(uiImage: ui) }
    return Image("recipePlaceholder")
  }

  private var labels: some View {
    VStack(alignment: .leading, spacing: 5) {
      Text(recipe.name).font(.headline)
      Text(recipe.summary).font(.subheadline)
      HStack(spacing: 5) {
        if let c = recipe.category { tag(c.name, icon: "tag") }
        tag("\(recipe.time)m", icon: "clock")
        tag("\(recipe.serving)p", icon: "person")
      }
      .padding(.top, 10)
      .padding(.bottom, 20)
    }
  }

  private func tag(_ title: String, icon: String) -> some View {
    Label(title, systemImage: icon)
      .font(.caption2).bold()
      .padding(.vertical, 5).padding(.horizontal, 10)
      .background(Color.accent.opacity(0.1))
      .foregroundStyle(.accent)
      .clipShape(Capsule())
  }
}
