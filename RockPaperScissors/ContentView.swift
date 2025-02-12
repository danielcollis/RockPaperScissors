//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Daniel Collis on 2/11/25.
//

import SwiftUI

struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissors"]
    let whatBeatsMoves = ["Paper", "Scissors", "Rock"]
    let whatLosesToMoves = ["Scissors", "Rock", "Paper"]
    @State private var cpuMove = Int.random(in: 0..<3)
    @State private var winOrLose = Bool.random()
    
    @State private var playerScore = 0
    
    var body: some View {
        ZStack {
            VStack {
                Text("Score: \(playerScore)")
                
                Text("Computer Move: \(moves[cpuMove])")
                
                Text((winOrLose) ? "What wins against \(moves[cpuMove])" : "What loses against \(moves[cpuMove])?")
                
                HStack {
                    ForEach(moves, id: \.self) { move in
                        Button {
                            if isAnswerCorrect(move) {
                                print("Correct")
                            } else {
                                print("Incorrect")
                            }
                            winOrLose.toggle()
                            cpuMove = Int.random(in: 0..<3)
                        } label : {
                            Text(displayEmoji(for: move))
                                .font(.largeTitle)
                        }
                    }
                }
            }
        }
    }
    
    func isAnswerCorrect(_ answer: String) -> Bool {
        switch winOrLose {
        case true:
            return answer == whatBeatsMoves[cpuMove]
        case false:
            return answer == whatLosesToMoves[cpuMove]
        }
    }
    
    func displayEmoji (for move: String) -> String {
        switch move {
        case "Rock":
            return "🪨"
        case "Paper":
            return "📄"
        case "Scissors":
            return "✂️"
        default:
            return "None"
        }
    }
}

#Preview {
    ContentView()
}
