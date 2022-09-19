//
//  RecipeModel.swift
//  QuickCook
//
//  Created by Seth Bangert on 9/19/22.
//

import Foundation

struct Recipe: Identifiable {
    var id = UUID()
    var name: String
    var content: String = ""
}
