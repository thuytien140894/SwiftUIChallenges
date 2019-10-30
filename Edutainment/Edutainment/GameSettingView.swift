//
//  GameSettingView.swift
//  Edutainment
//
//  Created by Tien Thuy Ho on 10/28/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import SwiftUI

struct GameSettingView: View {
    
    @Binding var questionSet: [MultiplicationQuestion]
    @Binding var gameIsSet: Bool
    @Binding var numberOfQuestions: NumberOfQuestions
    
    @State private var multiplicationTableNumber = 1
    @State private var possibleNumbersOfQuestions: [NumberOfQuestions] = [.five, .ten, .twenty, .all]
    
    var body: some View {
        Form {
            Stepper(value: $multiplicationTableNumber, in: 1...12) {
                Text("Multiplication table \(multiplicationTableNumber)")
            }
            
            Section(header: Text("How many questions would you  like to get asked?")) {
                Picker("Number of questions", selection: $numberOfQuestions) {
                    ForEach(possibleNumbersOfQuestions, id: \.self) {
                        Text($0.description)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Button("Start game") {
                self.setupGame()
            }
        }
    }
    
    private func setupGame() {
        
        questionSet = generateMultiplicationTableQuestions(number: multiplicationTableNumber)
        gameIsSet = true
    }
    
    private func generateMultiplicationTableQuestions(number: Int) -> [MultiplicationQuestion] {
        
        var questions: [MultiplicationQuestion] = []
        for index in 0...12 {
            let question = MultiplicationQuestion(firstOperand: index, secondOperand: number)
            questions.append(question)
        }
        
        return questions
    }
}
