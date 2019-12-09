//
//  ContentView.swift
//  FriendFace
//
//  Created by Tien Thuy Ho on 12/8/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: User.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \User.name, ascending: true)
    ]) var users: FetchedResults<User>
    
    var body: some View {
        NavigationView {
            List(users, id: \.self) { user in
                NavigationLink(destination: DetailView(user: user)) {
                    VStack(alignment: .leading) {
                        Text(user.wrappedName)
                            .font(.headline)
                        Text(user.wrappedEmail)
                    }
                }
            }
            .navigationBarTitle("FriendFace")
        }
        .onAppear(perform: fetchUsersIfNecessary)
    }
    
    private func fetchUsersIfNecessary() {
        
        let usersAreFetched = users.count > 0
        guard !usersAreFetched else { return }
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.context else {
                fatalError("Failed to retrieve context")
            }
            
            let decoder = JSONDecoder()
            decoder.userInfo[codingUserInfoKeyManagedObjectContext] = self.managedObjectContext
            if let _ = try? decoder.decode([User].self, from: data) {
                DispatchQueue.main.async {
                    if self.managedObjectContext.hasChanges {
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            let nserror = error as NSError
                            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                        }
                    }
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
