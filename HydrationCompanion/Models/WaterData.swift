//
//  WaterData.swift
//  HydrationApp
//
//  Created by Jesse Liu on 2021-05-25.
//  Description: structure representing an intake entry (amount, type of drink, date)
//

import Foundation

// Water data for a single day
struct WaterData: Identifiable, Codable {
    var amount:Int
    var drinkID:Int
    var date:Date
    var id:UUID?
    
    init(amount:Int, drink: Int) {
        self.amount = amount
        self.drinkID = drink
        self.date = Date()
        self.id = UUID()
    }
}
