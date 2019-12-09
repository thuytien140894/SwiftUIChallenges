//
//  DetailView.swift
//  FriendFace
//
//  Created by Tien Thuy Ho on 12/8/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    let user: User
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var users: FetchedResults<User>
    
    var body: some View {
        Form {
            Section(header: Text("Overview").font(.headline)) {
                Text("Age: ").fontWeight(.semibold) + Text("\(user.age)")
                Text("Email: ").fontWeight(.semibold) + Text("\(user.wrappedEmail)")
                Text("Address: ").fontWeight(.semibold) + Text("\(user.wrappedAddress)")
                Text("Company: ").fontWeight(.semibold) + Text("\(user.wrappedCompany)")
            }
            
            Section(header: Text("About").font(.headline)) {
                Text(user.wrappedAbout)
            }

            Section(header: Text("Friends").font(.headline)) {
                List(user.wrappedFriends, id: \.self) { friend in
                    NavigationLink(destination: DetailView(user: self.user(with: friend.wrappedId))) {
                        Text(friend.wrappedName)
                    }
                }
            }
        }
        .navigationBarTitle(user.wrappedName)
    }
    
    private func user(with id: String) -> User {
        
        return users.first(where: { $0.id == id }) ?? User(context: managedObjectContext)
    }
}
