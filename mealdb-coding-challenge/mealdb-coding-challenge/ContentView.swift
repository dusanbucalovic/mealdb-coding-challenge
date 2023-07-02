//
//  ContentView.swift
//  mealdb-coding-challenge
//
//  Created by Dusan Bucalovic
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MealListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .idle:
                    // Show a transparent view and fetch meals on appearance
                    Color.clear
                        .onAppear {
                            viewModel.fetchMeals()
                        }
                case .loading:
                    // Show a loading indicator while fetching meals
                    ProgressView()
                case .loaded(let meals):
                    // Display the meal list
                    MealListView(meals: meals)
                case .error(let error):
                    // Show an error message
                    ErrorView(message: error.localizedDescription)
                }
            }
            .navigationBarTitle("Meal List")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
