//
//  Constants.swift
//  HydrationApp
//
//  Created by Jesse Liu on 2021-05-26.
//

import Foundation
import SwiftUI

struct Constants {
    // Dummy model
    static var sampleModel = HydrationModel(amounts: [1100, 200, 300])
    
    // Drink type names
    static let drinks = ["Water", "Coffee", "Juice", "Other"]
    
    // Drink type colors
    static let drinkColors = [Color.blue, Color("coffee"), Color.orange, Color.gray]
    
    
    // Configuration Constants
    struct Config {
        // UserDefaults Keys
        static let saveKey = "key"
        static let dateKey = "date"
        static let goalKey = "goal"
        
        // Picker increments
        static let intakeIncrement = 50
        static let goalIncrement = 100
        static let baseGoal = 2000
    }
    
    
    // Default values
    struct defaultValues {
        
        // Default amounts for men's intake
        static let goalIndex = 17
        static let goal = goalIndex * Constants.Config.goalIncrement + Constants.Config.baseGoal
        
    }
    
    
}
