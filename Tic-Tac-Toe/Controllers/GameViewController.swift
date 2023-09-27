//
//  GameViewController.swift
//  Tic-Tac-Toe
//
//  Created by Nilufar Bakhridinova on 2023-09-13.
//

import UIKit

class GameViewController: UIViewController {
    
    var gameMode: GameMode = .PlayerVsAI
    
    @IBOutlet weak var lblO: UILabel!
    @IBOutlet weak var lblX: UILabel!
    @IBOutlet weak var lblPlayer1: UILabel!
    @IBOutlet weak var lblPlayer2: UILabel!
    @IBOutlet weak var lblInfoWinLoseDraw: UILabel!
    @IBOutlet weak var imgBtnOnPlayAgain: UIImageView!
    @IBOutlet var imgCell: [UIImageView]!
    
    

    var currentPlayer = 1
        var gameIsActive = true
        var isWaitingForAiMove = false
        
        var player1Name = ""
        var player2Name = ""
        
        let activePlayerColor = UIColor.yellow
        let inactivePlayerColor = UIColor.white

        var player1Score = 0
        var player2Score = 0
        
        var segueExit = "toWelcomeController"
        
        var imageCross = UIImage(named: "cross")
        var imageNought = UIImage(named: "nought")
        var imageCell = UIImage(named: "cell")
      
        let combinationOfWin = [[0,1,2],
                               [3,4,5],
                               [6,7,8],
                               [0,3,6],
                               [1,4,7],
                               [2,5,8],
                               [0,4,8],
                               [2,4,6]]
       
        override func viewDidLoad() {
            super.viewDidLoad()
        
            updatePlayersLabels()
            updatePlayerLabelColors()
            resetGame()
        }
        
    
    @IBAction func onCellTap(_ sender: UITapGestureRecognizer) {
 
            guard let tappedCell = sender.view as? UIImageView else { return }

            if gameIsActive && tappedCell.image == imageCell && !isWaitingForAiMove {
                // Make a move for the current player
                tappedCell.image = (currentPlayer == 1) ? imageCross : imageNought

                checkGameResult()

                // Checking the game mode and the player's move
                if gameMode == .PlayerVsAI && gameIsActive {
                    currentPlayer = 2
                    updatePlayersLabels()
                    updatePlayerLabelColors()

                    // Set isWaitingForAiMove to true to prevent player moves during AI's turn
                    isWaitingForAiMove = true

                    // Delay before computer move
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                        self.makeAIMove()
                        self.isWaitingForAiMove = false // Set back to false after AI move
                    }
                }
            }
        }

        
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == segueExit,
               let _ = segue.destination as? WelcomeViewController {
            }
        }




        func isGameDraw() -> Bool {
            //call the method allSatisfy to check if there are any empty cells left on the board
                return imgCell.allSatisfy { $0.image != imageCell }
            }

            func checkForWinner() -> Bool {
                //a loop that checks cells for winning positions
                for combination in combinationOfWin {
                    let (a, b, c) = (imgCell[combination[0]], imgCell[combination[1]], imgCell[combination[2]])
                    if a.image != imageCell, a.image == b.image, b.image == c.image {
                        return true
                    }
                }
                return false
            }
        
    //button onPlayAgain
    @IBAction func onPlayAgain(_ sender: UITapGestureRecognizer) {
        resetGame()
    }
    
    //onExitGame to exit if player want to continue the game
    @IBAction func onExitGame(_ sender: UITapGestureRecognizer) {
        //print("Exit")
                //
                let alert = UIAlertController(title: "Wait!", message: "Are you sure you want to leave the game?", preferredStyle: .alert)
                
                let actionYes = UIAlertAction(title: "Yes.", style: .default) { [self] _ in
                    // go to WelcomeViewController
                    performSegue(withIdentifier: self.segueExit, sender: nil)
                }
                
                let actionNo = UIAlertAction(title: "No.", style: .cancel, handler: nil)
                
                alert.addAction(actionYes)
                alert.addAction(actionNo)
                
                present(alert, animated: true, completion: nil)
    }
    
    //reset game and
    func resetGame() {
                gameIsActive = true
                lblInfoWinLoseDraw.isHidden = true
                imgBtnOnPlayAgain.isHidden = true
                currentPlayer = 1
                imgCell.forEach { $0.image = imageCell }
                updateUI()
                updatePlayerLabelColors()
            }

            func updateUI() {
                updatePlayersLabels()
                updateScoreLabels()
            }
    
    func updatePlayersLabels() {
        lblPlayer1.text = player1Name
        lblPlayer2.text = (gameMode == .PlayerVsPlayer) ? player2Name : "AI"
    }


            func updateScoreLabels() {
                //updating player score information
                lblX.text = String(player1Score)
                lblO.text = String(player2Score)
            }
        
    func updatePlayerLabelColors() {
        
        //print("currentPlayer: \(currentPlayer)")
        
        lblPlayer1.textColor = (currentPlayer == 1) ? activePlayerColor : inactivePlayerColor
        lblPlayer2.textColor = (currentPlayer == 2) ? activePlayerColor : inactivePlayerColor

        if gameMode == .PlayerVsPlayer {
            lblX.textColor = (currentPlayer == 1) ? activePlayerColor : inactivePlayerColor
            lblO.textColor = (currentPlayer == 2) ? activePlayerColor : inactivePlayerColor
        } else {
            lblX.textColor = (currentPlayer == 1) ? activePlayerColor : inactivePlayerColor
            lblO.textColor = (currentPlayer == 2) ? activePlayerColor : inactivePlayerColor
        }
    }
    


        //update players score if it wins
          func updateScore() {
                if currentPlayer == 1 {
                    player1Score += 1
                } else {
                    player2Score += 1
                }
                updateScoreLabels()
            }

            func showResult(message: String) {
                lblInfoWinLoseDraw.isHidden = false
                lblInfoWinLoseDraw.text = message
                gameIsActive = false
            }
    
    func checkGameResult() {
        if checkForWinner() {
            let winner = (currentPlayer == 1) ? player1Name : (gameMode == .PlayerVsPlayer ? player2Name : "AI")
            showResult(message: "\(winner) wins!")
            imgBtnOnPlayAgain.isHidden = false
            updateScore()
            updatePlayersLabels()
            gameIsActive = false
        } else if isGameDraw() {
            showResult(message: "It's a draw!")
            imgBtnOnPlayAgain.isHidden = false
            gameIsActive = false
        } else {
            currentPlayer = (currentPlayer == 1) ? 2 : 1
            updatePlayersLabels()
            updatePlayerLabelColors()
        }
    }

    
    
    func makeAIMove() {
        if gameIsActive && gameMode == .PlayerVsAI && currentPlayer == 2 {
            var emptyCells = [Int]()
            for (index, cell) in imgCell.enumerated() {
                if cell.image == imageCell {
                    emptyCells.append(index)
                }
            }

            if !emptyCells.isEmpty {
                let randomIndex = Int.random(in: 0..<emptyCells.count)
                let selectedCellIndex = emptyCells[randomIndex]
                imgCell[selectedCellIndex].image = imageNought
                
                checkGameResult()
            }
        }
    }
}
