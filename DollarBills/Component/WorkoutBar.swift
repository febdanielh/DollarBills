//
//  WorkoutBar.swift
//  DollarBills
//
//  Created by Abiyyu Firmansyah on 06/10/23.
//

import SwiftUI

import MapKit

struct WorkoutBar: View {
     @EnvironmentObject var vm:ViewModelWorkout
     @State var showWorkoutView = false
     @State var offset = Double.zero
    
     let workout: Workout
     let new: Bool
    
     var body: some View {
         VStack(alignment: .leading, spacing: 5) {
             HStack {
                 Text("Running")
                     .font(.headline)
                 Spacer()
                 if new {
                     Image(systemName: "circle.fill")
                         .foregroundColor(.red)
                         .font(.subheadline)
                         .opacity(vm.pulse ? 1:0)
                 } else {
                     Text(workout.date.formattedApple()) // Show formatted date

                 }
             }
             .animation(.default, value: vm.pulse)
            
             HStack {
                 // Show formatted distance
                 WorkoutStat(name: "Distance", value: workout.formattedDistance())
                 Spacer(minLength: 0)
                 // Show formatted duration
                 WorkoutStat(name: "Duration", value: workout.formattedDuration())
                 Spacer(minLength: 0)
                 // Show formatted pace
                 WorkoutStat(name: "Pace", value: workout.formattedPace())
                 Spacer(minLength: 0)
                 // Show formatted elevation
                 WorkoutStat(name: "Elevation", value: Measurement(value: workout.elevation, unit: UnitLength.meters).formatted())
                 Spacer(minLength: 0)

             }
         }
         .padding(.horizontal, 12)
         .padding(.vertical, 8)
         .materialBackground()
         .transition(.move(edge: .bottom).combined(with: .opacity))
//         .onTapGesture {
//             vm.zoomTo(workout)
//         }
         .if(!new) { $0
             .offset(x: 0, y: offset)
             .opacity((100 - offset)/100)
             .gesture(DragGesture(minimumDistance: 0)
                 .onChanged { value in
                     if value.translation.height > 0 {
                         offset = value.translation.height
                     }
                 }
                 .onEnded { value in
                     if value.predictedEndTranslation.height > 50 {
                         vm.selectedWorkout = nil // Skip training when it exceeds threshold
                     } else {
                         withAnimation(.spring()) {
                             offset = 0 // Reset offset at end of drag gesture
                         }
                     }
                 }
             )
         }
     }
}



struct WorkoutBar_Previews: PreviewProvider {
     static var previews: some View {
         ZStack {
             Map(mapRect: .constant(MKMapRect()))
             WorkoutBar(workout: .example, new: true)
                 .environmentObject(ViewModelWorkout())
         }
     }
}

struct WorkoutStat: View {
     let name: String
     let value: String
    
     var body: some View {
         VStack(spacing: 3) {
             Text(name)
                 .font(.subheadline)
                 .foregroundColor(.secondary)
             Text(value)
                 .font(.headline)
         }
     }
}
