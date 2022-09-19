//
//  EditorView.swift
//  QuickCook
//
//  Created by Seth Bangert on 9/19/22.
//

import SwiftUI
import Combine

struct EditorView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var recipe: Recipe
    
    var body: some View {
        TextEditor(text: $recipe.text)
            .onReceive(recipe.publisher(for: \.text), perform: setName)
            .onReceive(recipe.publisher(for: \.text)
                .debounce(for: 0.5, scheduler: RunLoop.main)
                .removeDuplicates()
            ) { _ in
                try? PersistenceController.shared.saveContext()
            }
            .navigationTitle(recipe.name)
    }
    
    func setName(from text: String) {
        let text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.count > 0 {
            recipe.name = String(text.prefix(25))
        } else {
            recipe.name = "New Recipe"
        }
    }
}

