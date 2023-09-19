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
    
   
    @IBOutlet var imgCell: [UIImageView]!
    

    var gameIsActive = false
    var currentPlayer = 1
  
    var player1Name = "Cross"
    var player2Name = "Nought"
 
    
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
        
        resetGame()

    }
    
    @IBAction func onCellTap(_ sender: UITapGestureRecognizer) {
        
        guard gameIsActive, let tappedCell = sender.view as? UIImageView else { return }
        
  

            if gameIsActive {
                // Make the move for the current player
                if currentPlayer == 1 {
                    tappedCell.image = imageCross
                } else {
                    tappedCell.image = imageNought
                }

                // Check for a winner
                if checkForWinner() {
                    let winner = (currentPlayer == 1) ? player1Name : player2Name
                    lblInfoWinLoseDraw.isHidden = false
                    lblInfoWinLoseDraw.text = "\(winner) wins!"
                    gameIsActive = false
                } else {
                    // If there is no winner, check for a draw
                    if isGameDraw() {
                        lblInfoWinLoseDraw.isHidden = false
                        lblInfoWinLoseDraw.text = "It's a draw!"
                        gameIsActive = false
                    } else {
                        // Switch to the next player's turn
                        currentPlayer = (currentPlayer == 1) ? 2 : 1
                    }
                }
            }
    }

    func isGameDraw() -> Bool {
        for cell in imgCell {
            if cell.image == imageCell {
                return false
            }
        }
        return true
    }
    
    func checkForWinner() -> Bool {
        
        for combination in combinationOfWin {
            let cell1 = imgCell[combination[0]]
            let cell2 = imgCell[combination[1]]
            let cell3 = imgCell[combination[2]]
            
            if cell1.image != imageCell && cell1.image == cell2.image && cell2.image == cell3.image {
              
                return true
            }
            
        }
        return false
    }
    
    @IBAction func onReset(_ sender: UITapGestureRecognizer) {
        resetGame()
    }
    
    func resetGame(){
        lblPlayer1.text = "PlayerX"
        lblPlayer2.text = "PlayerO"
        gameIsActive = true
        lblInfoWinLoseDraw.isHidden = true
        currentPlayer = 1
        
        //Resetting images in cells
        for cell in imgCell {
            cell.image = imageCell
        }
    }
    
    func updatePlayersLabels(){
        
        
    }
    


}
