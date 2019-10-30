//
//  ContentView.swift
//  HabitTracker
//
//  Created by Tien Thuy Ho on 11/12/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import SwiftUI

struct Activity: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let completionCount: Int
}

class ActivityList: ObservableObject {
    @Published var items: [Activity] = []
}

struct ContentView: View {
    
    @ObservedObject private var activityList = ActivityList()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activityList.items) {
                    Text($0.title)
                }
                .onDelete(perform: removeActivities)
            }
            .navigationBarTitle("Habit Tracker")
            .navigationBarItems(trailing:
                Button(action: {
                    let activity = Activity(title: "A", description: "B", completionCount: 0)
                    self.activityList.items.append(activity)
                }) {
                    Image(systemName: "plus")
                }
            )
        }
    }
    
    private func removeActivities(at offsets: IndexSet) {
        
        activityList.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
