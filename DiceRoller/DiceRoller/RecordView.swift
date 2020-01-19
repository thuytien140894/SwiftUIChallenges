//
//  RecordView.swift
//  DiceRoller
//
//  Created by Tien Thuy Ho on 1/20/20.
//  Copyright © 2020 Tien Thuy Ho. All rights reserved.
//

import SwiftUI

struct RecordView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: DiceRecord.entity(), sortDescriptors: []) var records: FetchedResults<DiceRecord>
    
    var body: some View {
        NavigationView {
            List(records, id: \.self) { record in
                VStack(alignment: .leading) {
                    Text("Number of \(record.diceType)-sided dices rolled: ")
                        .fontWeight(.bold)
                        + Text("\(record.numberOfDices)")
                    Text("Result: ")
                        .fontWeight(.bold)
                        + Text("\(record.result)")
                }
            }
            .navigationBarTitle("Results")
            .navigationBarItems(trailing: Button("Clear") {
                self.clearRecords()
            })
        }
    }
    
    private func clearRecords() {
        
        for record in records {
            self.managedObjectContext.delete(record)
            try? self.managedObjectContext.save()
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
