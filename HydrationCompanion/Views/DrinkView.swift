//
//  DrinkView.swift
//  HydrationApp
//
//  Created by Jesse Liu on 2021-05-28.
//  Description: Cell for each drink in the intake list
//

import SwiftUI

struct DrinkView: View {
    
    // View uses a WaterData instance
    var drink:WaterData
    
    var body: some View {
        
        ZStack {
            // Background
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(5)
                .shadow(color: .gray, radius: 3)
            
            // Info
            HStack {
                // Amount
                Text(String(drink.amount)+" mL")
                Spacer()
                
                // Type of drink
                Text(Constants.drinks[drink.drinkID])
                
                // Icon based on drink type
                Image(systemName: "drop.fill")
                    .foregroundColor(Constants.drinkColors[drink.drinkID])
                
                // Time entered
                Text(DateHelper.getTimeString(time: drink.date))
            }
            .padding()
        }
        
    }
}

struct DrinkView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkView(drink: Constants.sampleModel.intake[0])
    }
}
