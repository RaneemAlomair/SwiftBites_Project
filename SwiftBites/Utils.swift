
import SwiftUI

extension View {
  func alert(error: Binding<Error?>) -> some View {
    self.alert(isPresented: Binding<Bool>(
      get: { error.wrappedValue != nil },
      set: { if !$0 { error.wrappedValue = nil } }
    )) {
      Alert(
        title: Text("Error"),
        message: Text(error.wrappedValue?.localizedDescription ?? "Unknown error."),
        dismissButton: .default(Text("Dismiss"))
      )
    }
  }
}
