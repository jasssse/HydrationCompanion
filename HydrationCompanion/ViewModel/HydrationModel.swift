//
//  HydrationModel.swift
//  HydrationApp
//
//  Created by Jesse Liu on 2021-05-25.
//  Description: Main view model
//

import Foundation
import HealthKit

class HydrationModel: ObservableObject {
    
    
    // MARK: - Properties
    
    // Date
    @Published var date:Date
    
    // Goal (mL)
    @Published var goal:Int
    
    // Progress double (0.0 to 1.0)
    @Published var progress:Double
    
    // Total intake (mL)
    @Published var totalIntake:Int
    
    // Goal index (corresponds to index used in SettingsView)
    @Published var goalIndex:Int
    
    // Intake entries (see WaterData.swift)
    @Published private(set) var intake:[WaterData] {
        // When modified, call the save function
        didSet {
            save()
        }
    }
    
    // Health Model (see HealthModel.swift)
    @Published var health:HealthModel
    
    
    // MARK: - Initializers
    
    // Initializer takes a Health Model
    init(healthModel: HealthModel) {
        // Default values (male intake)
        self.goalIndex = Constants.defaultValues.goalIndex
        self.goal = Constants.defaultValues.goal
        self.progress = 0.0
        self.totalIntake = 0
        self.health = healthModel
        self.date = Date()
        
        // Load existing array of entries (it not null)
        if let data = UserDefaults.standard.data(forKey: Constants.Config.saveKey) {
            if let decoded = try? JSONDecoder().decode([WaterData].self, from: data) {
                self.intake = decoded
            } else {
                self.intake = [WaterData]()
            }
        } else {
            self.intake = [WaterData]()
        }
        
        
        // Load last date (if not null) and compare
        if let dateData = UserDefaults.standard.data(forKey: Constants.Config.dateKey) {
            if let decodedDate = try? JSONDecoder().decode(Date.self, from: dateData) {
                
                // If the last date is not the same date as today, log the data
                if !Calendar.current.isDateInToday(decodedDate) {
                    self.health.saveData(intake: self.intake)
                    self.intake = [WaterData]()
                }
            }
        }
        
        // Load last date (if not null) and compare
        if let goalData = UserDefaults.standard.data(forKey: Constants.Config.goalKey) {
            if let decodedGoalIndex = try? JSONDecoder().decode(Int.self, from: goalData) {
                self.goalIndex = decodedGoalIndex
            }
        }
        
        self.updateData()
    }
     
    
    // Second initializer with parameter for array of ints
    // * ONLY USED FOR DUMMY DATA!
    init(amounts:[Int]) {
        self.date = Date()
        self.goalIndex = Constants.defaultValues.goalIndex
        self.goal = Constants.defaultValues.goal
        self.progress = 0.0
        self.totalIntake = 0
        self.intake = [WaterData]()
        self.health = HealthModel()
        for i in (0..<amounts.count) {
            self.addIntake(amount: amounts[i], drink: 0)
        }
    }
    
    
    // MARK: - Model Functions
    
    // Save
    private func save() {
        if let encoded = try? JSONEncoder().encode(intake) {
            UserDefaults.standard.set(encoded, forKey: Constants.Config.saveKey)
        }
        
        if let encodedDate = try? JSONEncoder().encode(date) {
            UserDefaults.standard.set(encodedDate, forKey: Constants.Config.dateKey)
        }
        
        if let encodedGoalIndex = try? JSONEncoder().encode(goalIndex) {
            UserDefaults.standard.set(encodedGoalIndex, forKey: Constants.Config.goalKey)
        }
    }
    
    
    // Updates total intake and percentage
    private func updateTotal() {
        var total = 0
        for i in (0..<self.intake.count) {
            total += self.intake[i].amount
        }
        self.totalIntake = total
    }
    
    
    // Recalculates to progress double
    private func updateProgress() {
        self.progress = min(Double(totalIntake)/Double(goal), 1.0)

    }
    

    // Calls updateTotal and updateProgress
    private func updateData() {
        self.goal = self.goalIndex * Constants.Config.goalIncrement + Constants.Config.baseGoal
        self.updateTotal()
        self.updateProgress()
    }
    
    
    // Add new intake
    func addIntake(amount:Int, drink: Int) {
        self.intake.append(WaterData(amount: amount, drink: drink))
        self.updateData()
    }
    

    // Remove an intake
    func removeIntake(offset: IndexSet) {
        self.intake.remove(atOffsets: offset)
        self.updateData()
    }
    
    
    // Log data to health model
    func logIntake() {
        // Save data to the healthModel first
        self.health.saveData(intake: self.intake)
        
        // Empty the intake
        self.intake = [WaterData]()
        self.updateData()
    }
    
    
    // Save a new intake goal based on index
    func saveGoal(index: Int) {
        self.goalIndex = index
        self.goal = self.goalIndex * Constants.Config.goalIncrement + Constants.Config.baseGoal
        updateData()
        save()
    }
}
