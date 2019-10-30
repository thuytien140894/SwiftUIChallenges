//
//  ContentView.swift
//  Roshambo
//
//  Created by Tien Thuy Ho on 10/19/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var moveIndex = Int.random(in: 0...2)
    private let moves = ["Rock", "Paper", "Scissors"]
    
    @State private var score = 0
    @State private var shouldWin = false
    @State private var turn = 0
    @State var shouldEndGame = false
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                VStack {
                    Text("Score: \(score)")
                        .fontWeight(.bold)
                    Text(moves[moveIndex])
                    Text(shouldWin ? "You should win." : "You should lose.")
                }
                HStack {
                    ForEach(moves, id: \.self) { move in
                        Button(action: {
                            self.select(move: move)
                        }) {
                            Text(move)
                                .padding()
                                .foregroundColor(.blue)
                                .background(Color.white)
                                .clipShape(Capsule())
                        }
                    }
                }
            }
            .alert(isPresented: $shouldEndGame) {
                Alert(title: Text("Your score is \(score)!"), message: Text("Try again?"), dismissButton: .default(Text("Yes")) {
                    self.restart()
                })
            }
        }
    }
    
    private func select(move: String) {
        
        let result = compareMoves(move, moves[moveIndex])
        if (shouldWin && result) || !(shouldWin || result) {
            score += 1
        } else {
            score -= 1
        }
        
        nextTurn()
    }
    
    private func compareMoves(_ firstMove: String, _ secondMove: String) -> Bool {
        
        switch firstMove {
        case "Rock":
            return rockWins(secondMove)
        case "Paper":
            return paperWins(secondMove)
        case "Scissors":
            return scissorsWin(secondMove)
        default:
            print("Invalid move")
            return false
        }
    }
    
    private func rockWins(_ move: String) -> Bool {
        
        switch move {
        case "Rock":
            return false
        case "Paper":
            return false
        case "Scissors":
            return true
        default:
            print("Invalid move")
            return false
        }
    }
    
    private func paperWins(_ move: String) -> Bool {
        
        switch move {
        case "Rock":
            return true
        case "Paper":
            return false
        case "Scissors":
            return false
        default:
            print("Invalid move")
            return false
        }
    }
    
    private func scissorsWin(_ move: String) -> Bool {
        
        switch move {
        case "Rock":
            return false
        case "Paper":
            return true
        case "Scissors":
            return false
        default:
            print("Invalid move")
            return false
        }
    }
    
    private func nextTurn() {
        
        turn += 1
        shouldEndGame = turn >= 10
        
        moveIndex = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
    private func restart() {
        
        turn = -1
        score = 0
        nextTurn()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
