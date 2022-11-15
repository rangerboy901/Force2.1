//
//  WorkoutListScreen.swift
//  Force2.1
//
//  Created by Joseph William DeWeese on 11/14/22.
//

import SwiftUI

struct WorkoutListScreen: View {
        //MARK:  PROPERTIES
    @StateObject private var workoutListVM = WorkoutListViewModel()
    @State private var isPresented: Bool = false
    
    private func deleteWorkout(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let workout = workoutListVM.workouts[index]
                // delete the workout
            workoutListVM.deleteWorkout(workout: workout)
                // get all workouts
            workoutListVM.getAllWorkouts()
        }
    }
    let types = ["Strength", "Power", "Cardio", "HIIT", "Recover"]
    func colorize(type: String) -> Color {
        switch type {
        case "HIIT":
            return .blue
        case "Recover":
            return .indigo
        case "Strength":
            return .orange
        case "Cardio":
            return .red
        case "Power":
            return .green
        default:
            return .gray
            
        }
    }
    var body: some View {
        
        
        
        List{
            ForEach(workoutListVM.workouts, id: \.id) { workout in
                NavigationLink(destination: DetailScreen()){
                CardView(workout: workout)
            }
                    .cornerRadius(12)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))]), startPoint: .bottom, endPoint: .top))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(self.colorize(type: workout.workoutType ), lineWidth: 8.0))
                    .padding(.top, 10)
            }
            .onDelete(perform: deleteWorkout)
      
    }
        .listStyle(PlainListStyle())
            .navigationTitle("Daily Workouts")
            .navigationBarItems(
                trailing:
                  //MARK:  ADD WORKOUT BUTTON
                    Button {
                        isPresented = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.accentColor)
                            .frame(width: 40, height: 40)
                            .background(Color.white,in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.4), radius: 7, x: 7, y: 7)
                    })
            .sheet(isPresented: $isPresented, onDismiss: {
                workoutListVM.getAllWorkouts()
            },  content: {
                AddWorkoutScreen()
            })
            .embedInNavigationView()
        
            .onAppear(perform: {
                workoutListVM.getAllWorkouts()
            })
    }
    
}
struct WorkoutListScreen_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListScreen()
    }
}
struct CardView: View {
    //MARK:  PROPERTIES
    let workout: WorkoutViewModel
    func colorize(type: String) -> Color {
        switch type {
        case "HIIT":
            return .blue
        case "Recover":
            return .indigo
        case "Strength":
            return .orange
        case "Cardio":
            return .pink
        case "Power":
            return .green
        default:
            return .gray
            
        }
    }
    
    var body: some View {
        
        HStack {
            VStack(alignment: .center, spacing: 5) {
                Text(workout.title)
                    .foregroundColor(.accentColor)
                    .accessibilityAddTraits(.isHeader)
                    .font(.body)
                    .fontWeight(.bold)
                Text(workout.objective)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                Text(workout.releaseDate ?? "")
                .font(.footnote)
            }
            .padding(.all)
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(self.colorize(type: workout.workoutType ), lineWidth: 4))
            
                    Spacer()
               
                    Text(workout.workoutType)
                        .padding(4)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .accessibilityLabel("Workout type\(workout.workoutType) ")
                        .font(.caption)
                        .overlay(
                            Capsule().stroke(self.colorize(type: workout.workoutType ), lineWidth: 4))
                    
                }
        .padding(5)
            }
           
        }

