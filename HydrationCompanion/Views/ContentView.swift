//
//  ContentView.swift
//  HydrationApp
///
//  Created by Jesse Liu on 2021-05-25.
//

import SwiftUI

struct ContentView: View {
    // App uses two models
    private var health: HealthModel
    private var hydration: HydrationModel
    
    init() {
        health = HealthModel()
        hydration = HydrationModel(healthModel: health)
    }
    
    var body: some View {
        TodayView(hydration: hydration)
            .onAppear {
                
                // On appearance, request authorization of HealthKit
                // (App works without authorization)
                health.requestAuthorization { success in
                    if !success {
                        print("Access not granted!")
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
