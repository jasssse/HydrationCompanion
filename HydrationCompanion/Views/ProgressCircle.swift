//
//  ProgressCircle.swift
//  HydrationApp
//
//  Created by Jesse Liu on 2021-06-22.
//

import SwiftUI

// MARK: - Circular progress bar
struct ProgressCircle: View {
    // Progress and completion properties
    var progress:Double
    var complete:Bool
    
    var body: some View {
        ZStack {
            
            // If progress has been completed, simply display a green circle
            if complete {
                Circle()
                    .stroke(lineWidth: 20.0)
                    .opacity(1.0)
                    .foregroundColor(Color.green)
                    .animation(.linear, value: self.progress)
                    .shadow(color: .green, radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                 
            } else {
                
                // Background circle (lighter color)
                Circle()
                    .stroke(lineWidth: 20.0)
                    .opacity(0.3)
                    .foregroundColor(Color.blue)
                    .shadow(color: .blue, radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                
                
                // Foreground circle (deeper color)
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear, value: self.progress)
            }
            
            // Data and graphics within the circle
            VStack(spacing: 0) {
                HStack {
                    Text(String(format: "%.0f%%", min(self.progress, 1.0) * 100.0))
                        .font(.largeTitle)
                        .bold()
                    Image(systemName: "drop.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.blue)
                }
                Text("of daily goal")
                    .font(.caption)
            }
            .padding()
        }
    }
}

struct ProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircle(progress: 0.51, complete: false)
    }
}
