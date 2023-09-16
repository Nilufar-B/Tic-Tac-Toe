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
    

    var playerIsActive = true
    var activePlayer = 1
  
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
    
    func resetGame(){
        lblPlayer1.text = "Player 1"
        lblPlayer2.text = "Player 2"
        playerIsActive = true
        lblInfoWinLoseDraw.isHidden = true
        activePlayer = 1
        
        //Resetting images in cells
        for cell in imgCell {
            cell.image = UIImage(named: "cell")
        }
    }
    
   
    @IBAction func onCellTap(_ sender: UITapGestureRecognizer) {
        
        guard playerIsActive, let tappedCell = sender.view as? UIImageView else {return}
        
       // print("Tapped cell \(tappedCell.tag)")
        
        if tappedCell.image == UIImage(named: "cell") {
            if activePlayer == 1 {
                tappedCell.image = UIImage(named: "cross")
                activePlayer = 2
            }else {
                tappedCell.image = UIImage(named: "nought")
                activePlayer = 1
            }
            
            
            //check for winner
            if checkForWinner(){
                lblInfoWinLoseDraw.isHidden = false
                lblInfoWinLoseDraw.text = "Player \(activePlayer) wins!"
                playerIsActive = false
            } else{
                if isGameDraw(){
                    lblInfoWinLoseDraw.isHidden = false
                    lblInfoWinLoseDraw.text = "It's a draw!"
                    playerIsActive = false
                }
            }
        }
    }
    
    func isGameDraw() -> Bool {
        for cell in imgCell {
            if cell.image == UIImage(named: "cell") {
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
            
            if cell1.image != UIImage(named: "cell") && cell1.image == cell2.image && cell2.image == cell3.image {
                return true
            }
            
        }
        return false
    }
    
    @IBAction func onReset(_ sender: UITapGestureRecognizer) {
        resetGame()
    }
    


}
