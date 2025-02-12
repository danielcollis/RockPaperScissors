import SwiftUI

struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissors"]
    let whatBeatsMoves = ["Paper", "Scissors", "Rock"]
    let whatLosesToMoves = ["Scissors", "Rock", "Paper"]
    
    @State private var cpuMove = Int.random(in: 0..<3)
    @State private var winOrLose = Bool.random()
    
    @State private var showingResult = false
    @State private var resultText = ""
    
    @State private var playerScore = 0
    
    @State private var questionNumber = 1
    @State private var maxQuestionNumber = 4
    
    var body: some View {
            ZStack {
                VStack {
                    Text("Question: \(questionNumber)/\(maxQuestionNumber)")
                    
                    Text("Score: \(playerScore)")
                    
                    Text((winOrLose) ? "What wins against \(moves[cpuMove])?" : "What loses against \(moves[cpuMove])?")
                    
                    HStack {
                        ForEach(moves, id: \.self) { move in
                            Button {
                                isAnswerCorrect(move)
                            } label : {
                                Text(displayEmoji(for: move))
                                    .font(.largeTitle)
                            }
                            .alert(resultText, isPresented: $showingResult) {
                                questionNumber == maxQuestionNumber ?
                                Button("Restart") {restartGame()} : Button("Next Question") {nextQuestion()}
                            } message: {
                                Text(giveFullAnswerDescription())
                            }
                        }
                    }
                }
            }
    }
    
    func nextQuestion() {
        if questionNumber == maxQuestionNumber {
            restartGame()
        } else {
            questionNumber += 1
            cpuMove = Int.random(in: 0..<3)
            winOrLose = Bool.random()
        }
    }
    
    func getCorrectAnswer() -> String {
        var correctAnswer = ""
        
        switch winOrLose {
        case true:
            correctAnswer = whatBeatsMoves[cpuMove]
        case false:
            correctAnswer = whatLosesToMoves[cpuMove]
        }
        return correctAnswer
    }
    
    func isAnswerCorrect(_ answer: String) {
        if getCorrectAnswer() == answer {
            playerScore += 1
            resultText = "Correct!"
            
        } else {
            resultText = "Incorrect!"
        }
        
        showingResult = true
    }
    
    func giveFullAnswerDescription() -> String {
        (questionNumber == maxQuestionNumber) ?
        "Game Over! Your score: \(playerScore)/\(maxQuestionNumber)" :
        getAnswerDescription()
    }
    
    func getAnswerDescription() -> String {
        winOrLose ?
        "\(getCorrectAnswer()) beats \(moves[cpuMove])" : "\(getCorrectAnswer()) loses against \(moves[cpuMove])"
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
    
    func restartGame() {
        playerScore = 0
        questionNumber = 1
    }
}

#Preview {
    ContentView()
}
