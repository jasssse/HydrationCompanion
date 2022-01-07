//
//  InfoView.swift
//  HydrationApp
//
//  Created by Jesse Liu on 2021-06-01.
//  Description: The view for the information card
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack {
            Spacer()
            
            // Header
            Text("Info")
                .font(.largeTitle)
                .bold()
                .padding(.vertical)
            
            Spacer()
            
            // Intake measurement graphic
            VStack {
                Image(systemName: "drop.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75, height: 75)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                
                Image(systemName: "ruler")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, -20.0)
                    .frame(width: 75, height: 75)
            }
                
            
            // Info bit
            Text("Every day, we lose water through our breath, perspiration, urine and bowel movements. For our bodies to function properly, we must replenish its water supply by consuming beverages and foods that contain water.\nAdequate daily fluid intake is approximately:")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            
            // Intake recommendation for men/women
            VStack {
                Text("Men - 15.5 cups (3.7 L) of fluids daily")
                    .bold()
                    
                Text("Women - 11.5 cups (2.7 L) of fluids daily")
                    .bold()
                  
            }
            .padding()
            
            Spacer()
            
            
            // Icons for factors affecting intake goal
            HStack {
                Spacer()
                Image(systemName: "figure.walk")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, -20.0)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.orange)
                Spacer()
                Image(systemName: "cloud.sun")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, -20.0)
                    .frame(width: 60, height: 60)
                    .foregroundColor(.green)
                Spacer()
                Image(systemName: "cross.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, -20.0)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.red)
                Spacer()
            }
            .padding()
            
            
            // Info bit 2
            VStack {
                Text("Your total fluid intake may need to modified based on level of exercise, the environment (i.e. hot/humid weather increases sweat) and overall health")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // Source
                Text("Source: Mayo Clinic")
                    .bold()
                    .padding([.horizontal, .top])
                    .font(.caption2)
                
            }
            Spacer()
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
