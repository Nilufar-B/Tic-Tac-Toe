//
//  GameViewController.swift
//  Tic-Tac-Toe
//
//  Created by Nilufar Bakhridinova on 2023-09-13.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var lblO: UILabel!
    @IBOutlet weak var lblX: UILabel!
    @IBOutlet weak var lblPlayer1: UILabel!
    @IBOutlet weak var lblPlayer2: UILabel!
    @IBOutlet weak var lblInfoWinLoseDraw: UILabel!
    @IBOutlet weak var imgBtnOnPlayAgain: UIImageView!
    @IBOutlet var imgCell: [UIImageView]!
    
    var currentPlayer = 1
    var gameIsActive = true
    
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
            
            if tappedCell.image == imageCell && gameIsActive { // Check if cell is empty and game is active
                // Make the move for the current player
                tappedCell.image = (currentPlayer == 1) ? imageCross : imageNought
                
                if checkForWinner() {
                    let winner = (currentPlayer == 1) ? player1Name : player2Name
                    showResult(message: "\(winner) wins!")
                    imgBtnOnPlayAgain.isHidden = false
                    updateScore()
                    gameIsActive = false // continue the game after win
                } else if isGameDraw() {
                    showResult(message: "It's a draw!")
                    imgBtnOnPlayAgain.isHidden = false
                    gameIsActive = false // continue the game if it's draw
                } else {
                    currentPlayer = (currentPlayer == 1) ? 2 : 1
                   // updatePlayersLabels()
                    updatePlayerLabelColors()
                }
            }
                
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueExit,
           let _ = segue.destination as? WelcomeViewController {
       
            
        }
    }


    func isGameDraw() -> Bool {
            return imgCell.allSatisfy { $0.image != imageCell }
        }

        func checkForWinner() -> Bool {
            for combination in combinationOfWin {
                let (a, b, c) = (imgCell[combination[0]], imgCell[combination[1]], imgCell[combination[2]])
                if a.image != imageCell, a.image == b.image, b.image == c.image {
                    return true
                }
            }
            return false
        }
    
    @IBAction func onPlayAgain(_ sender: UITapGestureRecognizer) {
        resetGame()
    }
    
    @IBAction func onExitGame(_ sender: UITapGestureRecognizer) {
        //print("Exit")
        
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
    
    func resetGame() {
            gameIsActive = true
            lblInfoWinLoseDraw.isHidden = true
            imgBtnOnPlayAgain.isHidden = true
            currentPlayer = 1
            imgCell.forEach { $0.image = imageCell }
            updateUI()
            resetPlayerLabeleColors()
        }

        func updateUI() {
            updatePlayersLabels()
            updateScoreLabels()
        }

    func updatePlayersLabels() {
        lblPlayer1.text = player1Name
        lblPlayer2.text = player2Name
    }


        func updateScoreLabels() {
            lblX.text = String(player1Score)
            lblO.text = String(player2Score)
        }
    
    func updatePlayerLabelColors() {
        lblPlayer1.textColor = (currentPlayer == 1) ? activePlayerColor : inactivePlayerColor
        lblX.textColor = (currentPlayer == 1) ? activePlayerColor : inactivePlayerColor
        lblPlayer2.textColor = (currentPlayer == 2) ? activePlayerColor : inactivePlayerColor
        lblO.textColor = (currentPlayer == 2) ? activePlayerColor : inactivePlayerColor
    }
    
    func resetPlayerLabeleColors(){
        lblPlayer1.textColor = UIColor.white
        lblX.textColor = UIColor.white
        lblPlayer2.textColor = UIColor.white
        lblO.textColor = UIColor.white
    }

    
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
    
}
