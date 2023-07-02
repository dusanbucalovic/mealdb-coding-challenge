//
//  Meal.swift
//  mealdb-coding-challenge
//
//  Created by Dusan Bucalovic
//

import Foundation

struct Meal: Identifiable {
    let id: String
    let name: String
    let thumbnailURL: String
    var instructions: String
    var ingredients: [String]
}
