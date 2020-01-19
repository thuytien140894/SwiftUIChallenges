//
//  ContentView.swift
//  DiceRoller
//
//  Created by Tien Thuy Ho on 1/18/20.
//  Copyright © 2020 Tien Thuy Ho. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            DiceRollView()
                .tabItem {
                    Text("Roll Dice")
            }
            RecordView()
                .tabItem {
                    Text("Record")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
