//
//  AddWorkoutScreen.swift
//  Force2.1
//
//  Created by Joseph Wil;liam DeWeese on 11/14/22.
//

import SwiftUI

struct AddWorkoutScreen: View {
    //MARK:   PROPERTIES
    @StateObject private var addWorkoutVM = AddWorkoutViewModel()
    @Environment(\.presentationMode) var presentationMode
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
        List {
            
            Section(header: Text("Add/Edit Workout Details⇩").fontWeight(.bold).foregroundColor(.accentColor)) {
                
                TextField("Enter Workout Name...", text: $addWorkoutVM.title)
                    .padding()
                    .background(Color(UIColor.tertiarySystemFill))
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
                    .cornerRadius(10)
                    .foregroundColor(.primary)
            }
            Section(header: Text("Add/Edit Workout Objective⇩").fontWeight(.bold).foregroundColor(.accentColor)) {
                TextEditor(text: $addWorkoutVM.objective)
                    .frame(width: 350, height: 125, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
            }
            .padding(2)
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(10)
            .foregroundColor(.primary)
            
            
            Section(header: Text("Choose Workout Type:")){
                Picker("Workout Type:", selection: $addWorkoutVM.workoutType) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                    .padding()
                }
                .pickerStyle(SegmentedPickerStyle())
                .foregroundColor(.primary)
                .padding(4)
                
                
                DatePicker("Workout Date", selection: $addWorkoutVM.releaseDate)
                   
            }
                Button("Save"){
                    HapticManager.notification(type: .success)
                    addWorkoutVM.save()
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .foregroundColor(.primary)
               
                }
        .navigationTitle("Add Workout")
        .embedInNavigationView()
               
            }
      
        }
       


struct AddWorkoutScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutScreen()
    }
}
