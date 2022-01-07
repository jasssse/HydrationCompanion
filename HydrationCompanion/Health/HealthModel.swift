//
//  HealthModel.swift
//  HydrationApp
//
//  Created by Jesse Liu on 2021-05-31.
//  Wrapper model for HKHealthStore
//

import Foundation
import HealthKit

class HealthModel: ObservableObject {
    // main store
    @Published var store:HKHealthStore?
    
    // Initializer (does NOT ask for permission; fails if Healthkit is not available on current platform)
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            store = HKHealthStore()
        } else {
            fatalError("Healthkit not available on this platform!")
        }
    }
    
    
    // Request authorization from user
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        
        // Type of unit the app requests access to (dietary water)
        let waterType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryWater)!
        
        // Unwrap the store
        guard let store = self.store else {
            return completion(false)
        }
        
        // Make request with write permission only
        store.requestAuthorization(toShare: [waterType], read: []) { (success, error) in
            completion(success)
        }
    }
    
    
    // Save data to health store based on array of WaterData
    func saveData(intake:[WaterData]) {
        
        // Specify quantity type (dietary water)
        let quantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryWater)
        
        // Unwrap the health store
        if let store = self.store {
            
            // Loop for each water data structure
            for wd in intake {
                
                // Create new healthkit sample (data entry)
                let newSample =
                    HKQuantitySample.init(type: quantityType!, quantity: HKQuantity.init(unit: HKUnit.literUnit(with: .milli), doubleValue: Double(wd.amount)), start: wd.date, end: wd.date)
                
                // Store saves new sample
                store.save(newSample) { (success, error) in
                    if (error != nil) {
                        print("ERROR WITH SAVING: \(String(describing: error))")
                    }
                    if success {
                        print("SAVED: \(success)")
                    }
                }
            }
        }
    }
}

