//
//  TodayView.swift
//  HydrationApp
//
//  Created by Jesse Liu on 2021-05-25.
//  Description: The main view for intake and progress
//

import SwiftUI
import HealthKit

struct TodayView: View {
    init(hydration:HydrationModel) {
        self.hydration = hydration
        UITableView.appearance().backgroundColor = .clear }
    
    @ObservedObject var hydration:HydrationModel
    
    // Booleans for 3 sheet views
    @State var addIntakeSheet = false
    @State var settingsSheet = false
    @State var infoSheet = false
    
    var body: some View {
        VStack(spacing: 10) {
            
            // MARK: - Header
            HStack {
                Spacer()
                VStack {
                    // See DateHelper.swift
                    Text(DateHelper.getDateString(day: hydration.date))
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                    Text("Here is your fluid intake")
                        .italic()
                }
                Spacer()
            }
            
            
            // MARK: - Progress bar and goal display
            // See below for progress bar
            ProgressCircle(progress: hydration.progress, complete: (hydration.progress == 1.0))
                .frame(width: 175, height: 175)
                .padding(30.0)
            
            Text("\(hydration.totalIntake) mL / \(hydration.goal) mL")
                .bold()
            
            Spacer()
            
            
            // MARK: - List of intake entries
            List {
                // Calls DrinkView for reach entry (see DrinkView.swift)
                ForEach(hydration.intake) { i in
                    DrinkView(drink: i)
                }
                .onDelete(perform: delete)
            }

            
            // MARK: - Utility buttons
            HStack {
                
                // Info
                Button(action: { infoSheet.toggle() }, label: {
                    Image(systemName: "info.circle")
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .frame(width: 25, height: 25)
                        .padding(.leading)
                        .foregroundColor(.black)
                })
                .sheet(isPresented: $infoSheet, content: {
                    InfoView()
                })
                
                Spacer()
                
                // Add intake
                Button(action: { addIntakeSheet.toggle()}, label: {
                    HStack {
                        Text("Add Intake")
                        Image(systemName: "plus.circle")
                    }
                })
                .sheet(isPresented: $addIntakeSheet, content: {
                    AddIntakeView(hydration: hydration)
                })
                .buttonStyle(customButtonStyle())
                
                Spacer()
                
                // Settings
                Button(action: { settingsSheet.toggle() }, label: {
                    Image(systemName: "gearshape")
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .frame(width: 25, height: 25)
                        .padding(.trailing)
                        .foregroundColor(.black)
                })
                .sheet(isPresented: $settingsSheet, content: {
                    SettingsView(hydration: hydration, existingIndex: hydration.goalIndex)
                })
            }
        }.padding(.horizontal)
    }
    
    // Delete function used by the list's built-int deletion
    func delete(at offsets: IndexSet) {
        hydration.removeIntake(offset: offsets)
    }
}





struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview uses sample model (see Constants.swift) and an arbitrary HealthModel instance
        TodayView(hydration: Constants.sampleModel)
    }
}
