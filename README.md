# 🍽 SwiftBites  
**A modern SwiftUI app for managing recipes, ingredients, and categories  powered by SwiftData + MVVM architecture.**

---

## 🧩 Overview
SwiftBites helps users manage their favorite recipes, organize ingredients, and group them by categories all with offline persistence using **SwiftData**.

It’s built entirely in **SwiftUI**, following a clean **MVVM** structure that separates logic, models, and views for scalability and clarity.

---

## 🚀 Features
- 🧠 **MVVM architecture :**  clear separation of logic and UI.  
- 💾 **SwiftData integration :** automatic local persistence for all entities.  
- 🧂 **Ingredient management :** add, edit, delete, and reuse ingredients.  
- 🏷 **Category system :** organize recipes into custom categories.  
- 🍕 **Recipe builder :**  add instructions, time, servings, ingredients, and photos.  
- 🖼 **PhotoPicker support :** attach images to recipes easily.  
- 🔍 **Live search + sorting :** find recipes instantly by name, time, or servings.  
- 🌙 **Dark mode ready :** adapts seamlessly to iOS themes.

---

## 🖼 Screenshots
<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2025-10-26 at 15 39 57" src="https://github.com/user-attachments/assets/91649c76-9ff4-47d5-96ed-7b1056b19087" />
<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2025-10-26 at 15 40 03" src="https://github.com/user-attachments/assets/9002b2fb-e1b5-4c16-93a5-8adfa4fa5aff" />
<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2025-10-26 at 15 42 29" src="https://github.com/user-attachments/assets/345b063d-c409-44ff-96b2-4211a7387fbc" />
<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2025-10-26 at 15 43 07" src="https://github.com/user-attachments/assets/2db667e7-3bb5-45b2-865f-1102892bcdd7" />

<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2025-10-26 at 15 43 17" src="https://github.com/user-attachments/assets/b6a7253d-b8f4-4ebb-857f-1675bde4d4dd" />

---

## 🧱 Architecture

```
SwiftBites/
│
├── App/
│ ├── SwiftBitesApp.swift # Entry point + SwiftData modelContainer
│
├── Models/ # SwiftData entities
│ ├── Category.swift
│ ├── Ingredient.swift
│ ├── Recipe.swift
│ └── RecipeIngredient.swift
│
├── ViewModels/ # Business logic
│ ├── RecipesViewModel.swift
│ ├── RecipeFormViewModel.swift
│ ├── CategoriesViewModel.swift
│ ├── CategoryFormViewModel.swift
│ ├── IngredientsViewModel.swift
│ └── IngredientFormViewModel.swift
│
├── Views/ # SwiftUI interface
│ ├── Recipes/
│ │ ├── RecipesView.swift
│ │ ├── RecipeCell.swift
│ │ └── RecipeFormView.swift
│ │
│ ├── Categories/
│ │ ├── CategoriesView.swift
│ │ ├── CategorySection.swift
│ │ └── CategoryFormView.swift
│ │
│ ├── Ingredients/
│ │ ├── IngredientsView.swift
│ │ └── IngredientFormView.swift
│ │
│ └── Shared/
│ └── Utils.swift # Alerts, UI helpers, etc.
│
└── Assets/
└── AppIcon + Images
```


---

## 🧠 Data Model (SwiftData)

Each entity is annotated with `@Model`, persisted automatically by SwiftData.

```swift
@Model
final class Recipe {
    @Attribute(.unique) var id: UUID
    var name: String
    var summary: String
    var instructions: String
    var imageData: Data?
    var time: Int
    var serving: Int
    var category: Category?
    @Relationship(deleteRule: .cascade) var ingredients: [RecipeIngredient]
}
```
## 🧰 Dependencies  
✅ **SwiftUI**  
✅ **SwiftData**  
✅ **PhotosUI**  
✅ **Observation** *(for @Bindable / @Observable models)*  

No external libraries required.  

---

## 🪄 Setup & Run  
1️⃣ Open the project in **Xcode 16 or newer**  
2️⃣ Run on **iOS 17+ simulator or device**  
3️⃣ Add categories, ingredients, and recipes — your data is auto-saved via **SwiftData**!  

---

## 👩‍💻 Developer  
**Raneem Alomair**  
*iOS Developer | Apple Developer Academy Alumna*  
🔗 [raneemalomair.framer.website](https://raneemalomair.framer.website)
