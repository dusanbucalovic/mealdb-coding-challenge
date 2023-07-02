//
//  MealListView.swift
//  mealdb-coding-challenge
//
//  Created by Dusan Bucalovic
//

import SwiftUI

struct MealListView: View {
    let meals: [Meal]
    
    var body: some View {
        List(meals) { meal in
            NavigationLink(destination: MealDetailView(meal: meal)) {
                HStack {
                    // Display the meal thumbnail
                    AsyncImage(url: URL(string: meal.thumbnailURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            .cornerRadius(8)
                    } placeholder: {
                        // Show a placeholder if the thumbnail is not available
                        Color.gray
                            .frame(width: 60, height: 60)
                            .cornerRadius(8)
                    }
                    
                    // Display the meal name
                    Text(meal.name)
                }
            }
        }
    }
}
