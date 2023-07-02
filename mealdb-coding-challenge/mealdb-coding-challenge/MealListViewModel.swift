//
//  MealListViewModel.swift
//  mealdb-coding-challenge
//
//  Created by Dusan Bucalovic
//

import Foundation

class MealListViewModel: ObservableObject {
    @Published var state: State = .idle
    
    // Fetch meals from the API
    func fetchMeals() {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            // If the URL is invalid, set the state to error and return
            state = .error(APIError.invalidURL)
            return
        }
        
        // Set the state to loading
        state = .loading
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    // If there is an error, set the state to error and return
                    self.state = .error(error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    // If the data is invalid, set the state to error and return
                    self.state = .error(APIError.invalidData)
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MealListResponse.self, from: data)
                
                DispatchQueue.main.async {
                    let meals = response.meals.map { meal in
                        Meal(id: meal.idMeal,
                             name: meal.strMeal,
                             thumbnailURL: meal.strMealThumb,
                             instructions: "",
                             ingredients: [])
                    }
                    // Set the state to loaded with the fetched meals
                    self.state = .loaded(meals)
                }
            } catch {
                DispatchQueue.main.async {
                    // If there is a decoding error, set the state to error and return
                    self.state = .error(error)
                }
            }
        }.resume()
    }
}

extension MealListViewModel {
    enum State {
        case idle // The initial state when no meals are fetched
        case loading // The state when meals are being fetched
        case loaded([Meal]) // The state when meals are successfully fetched and available
        case error(Error) // The state when an error occurs during the API request
    }
    
    enum APIError: Error {
        case invalidURL // Error when the API URL is invalid
        case invalidData // Error when the fetched data is invalid
    }
}

struct MealListResponse: Codable {
    let meals: [MealResponse]
    
    struct MealResponse: Codable {
        let idMeal: String
        let strMeal: String
        let strMealThumb: String
        
        private enum CodingKeys: String, CodingKey {
            case idMeal, strMeal, strMealThumb
        }
    }
}
