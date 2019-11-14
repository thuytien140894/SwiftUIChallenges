//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Tien Thuy Ho on 11/13/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import SwiftUI

struct AddHabitView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var activityList: ActivityList
    
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationBarTitle("Add new habit")
            .navigationBarItems(trailing:
                Button("Save") {
                    let activity = Activity(title: self.title, description: self.description)
                    self.activityList.items.append(activity)
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(activityList: ActivityList())
    }
}
