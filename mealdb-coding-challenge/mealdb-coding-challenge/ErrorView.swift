//
//  ErrorView.swift
//  mealdb-coding-challenge
//
//  Created by Dusan Bucalovic
//

import SwiftUI

struct ErrorView: View {
    let message: String
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.circle")
                .font(.system(size: 60))
                .foregroundColor(.red)
            
            Text(message)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
