//
//  MealDetailView.swift
//  mealdb-coding-challenge
//
//  Created by Dusan Bucalovic
//

import SwiftUI

struct MealDetailView: View {
    let meal: Meal
    
    @State private var mealCopy: Meal
    
    init(meal: Meal) {
        self.meal = meal
        _mealCopy = State(initialValue: meal)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: meal.thumbnailURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Color.gray
                }
                
                Text("Ingredients")
                    .font(.headline)
                
                ForEach(mealCopy.ingredients, id: \.self) { ingredient in
                    Text(ingredient)
                }
                
                Text("Instructions")
                    .font(.headline)
                
                Text(mealCopy.instructions)
                    .fixedSize(horizontal: false, vertical: true) // Allow multiline text

            }
            .padding()
            .onAppear {
                fetchMealDetails()
            }
        }
    }
    
    func fetchMealDetails() {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(meal.id)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Invalid data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MealDetailResponse.self, from: data)
                
                DispatchQueue.main.async {
                    if let mealDetail = response.meals.first {
                        var updatedMeal = mealCopy // Create a mutable copy of the meal
                        updatedMeal.instructions = mealDetail.strInstructions
                        updatedMeal.ingredients = getIngredients(from: mealDetail)
                        mealCopy = updatedMeal // Assign the updated meal back to the mealCopy property
                    }
                }
            } catch {
                print("Error decoding meal details: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    private func getIngredients(from mealDetail: MealDetailResponse.MealDetail) -> [String] {
        var ingredients: [String] = []
        
        let mirror = Mirror(reflecting: mealDetail)
        
        for child in mirror.children {
            if let value = child.value as? String, child.label?.hasPrefix("strIngredient") == true {
                if let measureLabel = mirror.children.first(where: { $0.label == "strMeasure\(child.label?.replacingOccurrences(of: "strIngredient", with: "") ?? "")" })?.value as? String {
                    if !value.isEmpty && !measureLabel.isEmpty {
                        ingredients.append("\(value) - \(measureLabel)")
                    } else if !value.isEmpty {
                        ingredients.append(value)
                    }
                } else if !value.isEmpty {
                    ingredients.append(value)
                }
            }
        }
        
        return ingredients
    }
}

struct MealDetailResponse: Codable {
    let meals: [MealDetail]
    
    struct MealDetail: Codable {
        let strInstructions: String
        let strIngredient1: String?
        let strIngredient2: String?
        let strIngredient3: String?
        let strIngredient4: String?
        let strIngredient5: String?
        let strIngredient6: String?
        let strIngredient7: String?
        let strIngredient8: String?
        let strIngredient9: String?
        let strIngredient10: String?
        let strIngredient11: String?
        let strIngredient12: String?
        let strIngredient13: String?
        let strIngredient14: String?
        let strIngredient15: String?
        let strIngredient16: String?
        let strIngredient17: String?
        let strIngredient18: String?
        let strIngredient19: String?
        let strIngredient20: String?
        let strIngredient21: String?
        let strIngredient22: String?
        let strIngredient23: String?
        let strIngredient24: String?
        let strIngredient25: String?
        // Add more properties for the remaining ingredients
        
        let strMeasure1: String?
        let strMeasure2: String?
        let strMeasure3: String?
        let strMeasure4: String?
        let strMeasure5: String?
        let strMeasure6: String?
        let strMeasure7: String?
        let strMeasure8: String?
        let strMeasure9: String?
        let strMeasure10: String?
        let strMeasure11: String?
        let strMeasure12: String?
        let strMeasure13: String?
        let strMeasure14: String?
        let strMeasure15: String?
        let strMeasure16: String?
        let strMeasure17: String?
        let strMeasure18: String?
        let strMeasure19: String?
        let strMeasure20: String?
        let strMeasure21: String?
        let strMeasure22: String?
        let strMeasure23: String?
        let strMeasure24: String?
        let strMeasure25: String?
        // Add more properties for the remaining measurements
        
        private enum CodingKeys: String, CodingKey {
            case strInstructions
            case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20, strIngredient21, strIngredient22, strIngredient23, strIngredient24, strIngredient25
            // Add more cases for the remaining ingredients
            
            case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20, strMeasure21, strMeasure22, strMeasure23, strMeasure24, strMeasure25
            // Add more cases for the remaining measurements
        }
    }
}
