//
//  WelcomeViewController.swift
//  Tic-Tac-Toe
//
//  Created by Nilufar Bakhridinova on 2023-09-13.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var btnPlayWithFriend: UIImageView!
    @IBOutlet weak var btnPlayWithAI: UIImageView!
    
    //var gameMode = GameMode.single
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //make sure that i use those highlighted setup's in setupGame function
    @IBAction func onTapPlayWithAI(_ sender: UITapGestureRecognizer) {
        btnPlayWithAI.isHighlighted = true
        btnPlayWithFriend.isHighlighted = false
        
    }
    
    
    @IBAction func onTapPlayWithFriend(_ sender: UITapGestureRecognizer) {
        btnPlayWithAI.isHighlighted = false
        btnPlayWithFriend.isHighlighted = true
    }
    
    @IBAction func onPlay(_ sender: UITapGestureRecognizer) {
        
        
    }
    
   // func setupGame(gameMode: GameMode, player1Name: String, player2Name: String){
        //use switch to choose the gameMode
   // }
    
}
