//
//  DiceRollView.swift
//  DiceRoller
//
//  Created by Tien Thuy Ho on 1/20/20.
//  Copyright © 2020 Tien Thuy Ho. All rights reserved.
//

import SwiftUI

struct DiceRollView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext

    @State private var numberOfDices = 1
    @State private var diceType = 4
    @State private var total = 0
    @State private var results: [Int] = [0]
    
    private var allDiceTypes = [4, 6, 8, 10, 12, 20, 100]
    
    var body: some View {
        let diceCount = Binding<Int>(
            get: { self.numberOfDices },
            set: {
                self.numberOfDices = $0
                self.results = Array(repeating: 0, count: self.numberOfDices)
            }
        )
        
        return NavigationView {
            GeometryReader { geo in
                VStack {
                    Form {
                        Stepper(value: diceCount, in: 1...10) {
                            Text("\(self.numberOfDices) dices")
                        }
                        Picker("Dice type", selection: self.$diceType) {
                            ForEach(self.allDiceTypes, id: \.self) {
                                Text("\($0)-sided")
                            }
                        }
                    }
                    .frame(height: geo.size.height * 0.2)
                    
                    ScrollView(.vertical, showsIndicators: true) {
                        ForEach(0..<self.numberOfDices, id: \.self) { index in
                            HStack(spacing: 100) {
                                Text("Dice \(index): ")
                                Text("\(self.results[index])")
                            }
                            .padding()
                        }
                    }
                    
                    Text("Total: \(self.total)")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                }
                .navigationBarTitle("Roll Dice")
                .navigationBarItems(trailing: Button("Roll") {
                    self.rollDices()
                })
            }
        }
    }
    
    private func rollDices() {
        
        var newResults: [Int] = []
        
        let group = DispatchGroup()
        
        for index in 1...20 {
            group.enter()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 + Double(index / 10)) {
                newResults = []
                for _ in 0..<self.numberOfDices {
                    let result = Int.random(in: 1...self.diceType)
                    newResults.append(result)
                }
                
                self.results = newResults
                self.total = self.results.reduce(0) { $0 + $1 }
                
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            let newRecord = DiceRecord(context: self.managedObjectContext)
            newRecord.numberOfDices = Int16(self.numberOfDices)
            newRecord.diceType = Int16(self.diceType)
            newRecord.result = Int16(self.total)
          
            try? self.managedObjectContext.save()
        }
    }
}

struct DiceRollView_Previews: PreviewProvider {
    static var previews: some View {
        DiceRollView()
    }
}
