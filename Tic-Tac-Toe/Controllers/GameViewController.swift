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
    @IBOutlet weak var btnReser: UIImageView!
    @IBOutlet weak var imgBtnOnPlayAgain: UIImageView!
    @IBOutlet var imgCell: [UIImageView]!
    
    var currentPlayer = 1
    var gameIsActive = true
    var player1Name = ""
    var player2Name = ""
    var player1Score = 0
    var player2Score = 0
 
    
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
        resetGame()

    }
    
    @IBAction func onCellTap(_ sender: UITapGestureRecognizer) {
        
        guard let tappedCell = sender.view as? UIImageView else { return }
            
            if tappedCell.image == imageCell && gameIsActive { // Проверьте, что клетка пуста и игра активна
                // Make the move for the current player
                tappedCell.image = (currentPlayer == 1) ? imageCross : imageNought
                
                if checkForWinner() {
                    let winner = (currentPlayer == 1) ? player1Name : player2Name
                    showResult(message: "\(winner) wins!")
                    imgBtnOnPlayAgain.isHidden = false
                    updateScore()
                    gameIsActive = false // Завершите игру после победы
                } else if isGameDraw() {
                    showResult(message: "It's a draw!")
                    imgBtnOnPlayAgain.isHidden = false
                    gameIsActive = false // Завершите игру в случае ничьей
                } else {
                    currentPlayer = (currentPlayer == 1) ? 2 : 1
                    updatePlayersLabels()
                }
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
    @IBAction func onReset(_ sender: UITapGestureRecognizer) {
       
    }
    
    @IBAction func onPlayAgain(_ sender: UITapGestureRecognizer) {
        resetGame()
    }
    
    func resetGame() {
            gameIsActive = true
            lblInfoWinLoseDraw.isHidden = true
        imgBtnOnPlayAgain.isHidden = true
            currentPlayer = 1
            imgCell.forEach { $0.image = imageCell }
            updateUI()
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
