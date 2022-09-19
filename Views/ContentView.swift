//
//  ContentView.swift
//  QuickCook
//
//  Created by Seth Bangert on 9/19/22.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)])
    
    var recipes: FetchedResults<Recipe>
    
    @State private var selectedRecipesIds: Set<Recipe.ID> = []
    
    private var selectedRecipe: Recipe? {
        guard let selectedRecipeId = selectedRecipesIds.first,
              let selectedRecipe = recipes.filter({ $0.id == selectedRecipeId }).first else {
            return nil
        }
        return selectedRecipe
        
    }
    
    var body: some View {
        if #available(macOS 13.0, *) {
            NavigationSplitView {
                
                List(recipes, selection: $selectedRecipesIds) { rec in
                    NavigationLink(rec.name, value: rec)
                }
            } detail: {
                if let rec = selectedRecipe {
                    EditorView(recipe: rec)
                } else {
                    Text("No Recipe Selected!")
                        .foregroundColor(.secondary)
                }
            }
            .onDeleteCommand(perform: deleteSelectedRecipes)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: createRecipe) {
                        Label("Create New Recipe", systemImage: "square.and.pencil")
                    }
                }
            }
        } else {
            // Fallback on earlier versions
            
        
        }
    }
        
    
    private func createRecipe() {
        Task { await createRecipe(name: "New Recipe", text: "")}
    }
    
    private func createRecipe(name: String, text: String) async {
        await viewContext.perform {
            let rec = Recipe(context: viewContext)
            rec.id = UUID()
            rec.name = name
            rec.text = text
        }
        try? PersistenceController.shared.saveContext()
    }
    
    private func deleteSelectedRecipes() {
        let selectedRecipes = recipes.filter { selectedRecipesIds.contains($0.id) }
        Task { await deleteRecipes(recipes: selectedRecipes) }
    }
    
    private func deleteRecipes(recipes: [Recipe]) async {
        await viewContext.perform { recipes.forEach(viewContext.delete) }
        try? PersistenceController.shared.saveContext()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
