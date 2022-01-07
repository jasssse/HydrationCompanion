//
//  IntakeView.swift
//  HydrationApp
//
//  Created by Jesse Liu on 2021-05-27.
//  View for adding new Intake
//

import SwiftUI

struct AddIntakeView: View {
    
    // View writes to a hydration model
    var hydration:HydrationModel
    
    // presentationMode property used to close the sheet
    @Environment(\.presentationMode) var presentationMode
    
    // Default indices for amount and drink type
    @State var amountIndex = 9
    @State var drinkIndex = 0
    
    var body: some View {
        VStack(spacing: 20) {

            // Header
            Text("New Intake")
                .font(.largeTitle)
                .bold()
                .padding(.vertical)
                
            
            // Drink type picker
            Picker(selection: $drinkIndex, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/, content: {
                ForEach(0..<Constants.drinks.count) { i in
                    Text(Constants.drinks[i]).tag(i)
                }
                
            })
            .pickerStyle(SegmentedPickerStyle())
            .padding(.vertical)
            
            
            // Drop icon that corresponds to selected drink type
            Image(systemName: "drop.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(Constants.drinkColors[drinkIndex])
            
            
            // Amount picker
            Picker(selection: $amountIndex, label: Text("Picker"), content: {
                ForEach(1..<51) { number in
                    Text("\(number * Constants.Config.intakeIncrement) mL")
                }
            })
            .pickerStyle(WheelPickerStyle())
            
            
            // Save button
            Button(action: {
                
                // Model adds new intake (see HydrationModel.swift)
                hydration.addIntake(amount: ((amountIndex + 1) * Constants.Config.intakeIncrement), drink: drinkIndex)
                // After saving, close this view (sheet goes away in the app)
                self.presentationMode.wrappedValue.dismiss()
                
            }, label: {
                HStack {
                    Text("Save")
                    Image(systemName: "square.and.arrow.down")
                }
                .frame(width: 200, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            })
            .buttonStyle(customButtonStyle())

            Spacer()
            
        }
        .padding()
    }
}

struct AddIntakeView_Previews: PreviewProvider {
    static var previews: some View {
        AddIntakeView(hydration: Constants.sampleModel)
    }
}


