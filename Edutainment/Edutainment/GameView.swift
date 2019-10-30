//
//  GameView.swift
//  Edutainment
//
//  Created by Tien Thuy Ho on 10/28/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import SwiftUI

struct GameView: View {

    @Binding private var questionSet: [MultiplicationQuestion]
    @Binding private var numberOfQuestions: NumberOfQuestions
    @Binding private var numberOfCorrectAnswers: Int
    @Binding private var gameIsFinished: Bool
    
    @State private var currentQuestionIndex = 0
    @State private var answer = ""
    @State private var counter = 0
    
    private var askAllQuestions: Bool {
        if numberOfQuestions.toInt() != nil {
            return false
        }
        
        return true
    }
    
    private var currentQuestion: MultiplicationQuestion {
        return questionSet[currentQuestionIndex]
    }
    
    init(questionSet: Binding<[MultiplicationQuestion]>, numberOfQuestions: Binding<NumberOfQuestions>, numberOfCorrectAnswers: Binding<Int>, gameIsFinished: Binding<Bool>) {
        
        _questionSet = questionSet
        _numberOfQuestions = numberOfQuestions
        _numberOfCorrectAnswers = numberOfCorrectAnswers
        _gameIsFinished = gameIsFinished
        
        currentQuestionIndex = askAllQuestions ? 0 : Int.random(in: 0..<self.questionSet.count)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("\(currentQuestion.firstOperand) X \(currentQuestion.secondOperand)")
                TextField("Answer", text: $answer, onEditingChanged: { _ in }, onCommit: submitAnswer)
                    .keyboardType(.numberPad)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                )
                    .frame(width: 100, height: 25, alignment: .center)
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    private func submitAnswer() {
        
        guard let number = Int(answer) else { return }
        if number == currentQuestion.answer {
            numberOfCorrectAnswers += 1
        }
        
        answer = ""
        nextQuestion()
    }
    
    private func nextQuestion() {
        
        if askAllQuestions {
            nextOrderedQuestion()
        } else {
            nextRandomQuestion()
        }
    }
    
    private func nextOrderedQuestion() {
        
        if currentQuestionIndex < (questionSet.count - 1) {
            currentQuestionIndex += 1
        } else {
            gameIsFinished = true
        }
    }
    
    private func nextRandomQuestion() {
        
        counter += 1
        
        guard let questionCount = numberOfQuestions.toInt() else { return }
        if counter == questionCount {
            gameIsFinished = true
            return
        }
        
        currentQuestionIndex = Int.random(in: 0..<self.questionSet.count)
    }
}
