//
//  SettingsView.swift
//  HydrationApp
//
//  Created by Jesse Liu on 2021-06-01.
//  Description: View for the settings interface
//

import SwiftUI

struct SettingsView: View {
    
    // View writes to both the hydration model and health model
    @ObservedObject var hydration:HydrationModel
    
    // presentationMode property used to close the sheet
    @Environment(\.presentationMode) var presentationMode
    @State var existingIndex:Int
    
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Header
            Text("Settings")
                .font(.largeTitle)
                .bold()
                .padding(.vertical)
                
            Text("Set your goal:")
                .font(.callout)
            
            
            // Goal amount picker
            Picker(selection: $existingIndex, label: Text("Picker"), content: {
                ForEach(0..<42) { number in
                    Text("\(number * 100 + 2000) mL")
                }
            })
            .pickerStyle(WheelPickerStyle())
            
            
            // Save button
            Button(action: {

                // Model saves new goal
                hydration.saveGoal(index: existingIndex)
                // After saving, close this view (sheet goes away in the app)
                self.presentationMode.wrappedValue.dismiss()
                
            }, label: {
                HStack {
                    Text("Save Goal")
                    Image(systemName: "square.and.arrow.down")
                }
                .frame(width: 200, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            })
            .buttonStyle(customButtonStyle())
            
            
            // Log button
            Button(action: {
                
                // Call the log function
                // See HydrationModel.swift
                hydration.logIntake()
                // After logging, close this view (sheet goes away in the app)
                self.presentationMode.wrappedValue.dismiss()
                
            }, label: {
                HStack {
                    Text("Log to Health")
                    Image(systemName: "heart.circle.fill")
                }
                .frame(width: 200, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            })
            .buttonStyle(secondaryButtonStyle())

            Spacer()
            
            
            // Information box for logging
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                Text("Logging to health deletes all intake listings from this app! Intake is logged and reset automatically at the start of each day")
                    .bold()
                    .font(.caption)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.leading)
                    .padding()
            }
            .frame(width: 350, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
            
            Spacer()
        }
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(hydration: Constants.sampleModel, existingIndex: 17)
    }
}
