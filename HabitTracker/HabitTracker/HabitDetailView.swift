//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Tien Thuy Ho on 11/13/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import SwiftUI

struct HabitDetailView: View {
    
    @ObservedObject var activityList: ActivityList
    var activityIndex: Int
    
    private var activity: Activity {
        return activityList.items[activityIndex]
    }
    
    var body: some View {
        NavigationView {
            Form {
                Text(activity.description)
                HStack {
                    Text("Completion: \(activity.completionCount)")
                    Spacer()
                    Button(action: {
                        self.incrementActivityCompletionCount()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationBarTitle(activity.title)
        }
    }
    
    private func incrementActivityCompletionCount() {
        
        let updatedActivity = Activity(title: activity.title,
                                       description: activity.description,
                                       completionCount: activity.completionCount + 1)
        activityList.items[activityIndex] = updatedActivity
    }
}
