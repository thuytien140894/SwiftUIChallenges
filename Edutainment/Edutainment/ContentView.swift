//
//  ContentView.swift
//  Edutainment
//
//  Created by Tien Thuy Ho on 10/28/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var questionSet: [MultiplicationQuestion] = []
    @State private var numberOfQuestions: NumberOfQuestions = .five
    @State private var numberOfCorrectAnswers = 0
    @State private var gameIsSet = false
    @State private var gameIsFinished = false
    
    var body: some View {
        NavigationView {
            Group {
                if gameIsSet {
                    GameView(questionSet: $questionSet, numberOfQuestions: $numberOfQuestions, numberOfCorrectAnswers: $numberOfCorrectAnswers, gameIsFinished: $gameIsFinished)
                        .alert(isPresented: $gameIsFinished) {
                            Alert(title: Text("You got \(self.numberOfCorrectAnswers) correct answers."), message: Text("Try again?"), dismissButton: .default(Text("Yes")) {
                                self.restart()
                                })
                    }
                } else {
                    GameSettingView(questionSet: $questionSet, gameIsSet: $gameIsSet, numberOfQuestions: $numberOfQuestions)
                }
            }
            .navigationBarTitle("Edutainment")
        }
    }
    
    private func restart() {
        
        gameIsSet = false
        gameIsFinished = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
