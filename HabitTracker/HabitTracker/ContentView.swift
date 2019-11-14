//
//  ContentView.swift
//  HabitTracker
//
//  Created by Tien Thuy Ho on 11/12/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import SwiftUI

struct Activity: Codable, Identifiable {
    let id = UUID()
    let title: String
    let description: String
    var completionCount = 0
}

class ActivityList: ObservableObject {
    
    @Published var items: [Activity] = [] {
        didSet {
            let encoder = JSONEncoder()
            if let encodedItems = try? encoder.encode(items) {
                UserDefaults.standard.set(encodedItems, forKey: "Activities")
            }
        }
    }
    
    init() {
        
        guard let encodedItems = UserDefaults.standard.data(forKey: "Activities") else { return }
        
        let decoder = JSONDecoder()
        if let decodedItems = try? decoder.decode([Activity].self, from: encodedItems) {
            items = decodedItems
        }
    }
}

struct ContentView: View {
    
    @ObservedObject private var activityList = ActivityList()
    @State private var showAddHabit = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<activityList.items.count, id: \.self) { index in
                    NavigationLink(destination: HabitDetailView(activityList: self.activityList, activityIndex: index)) {
                        Text(self.activityList.items[index].title)
                    }
                }
                .onDelete(perform: removeActivities)
            }
            .navigationBarTitle("Habit Tracker")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showAddHabit = true
                }) {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $showAddHabit) {
            AddHabitView(activityList: self.activityList)
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
