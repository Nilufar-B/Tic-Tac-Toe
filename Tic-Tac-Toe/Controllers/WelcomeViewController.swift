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
    
    @IBOutlet weak var txtPlayer1Name: UITextField!
    @IBOutlet weak var txtPlayer2Name: UITextField!
    @IBOutlet weak var txtPlayerWithAIName: UITextField!
    
    @IBOutlet weak var stackViewPlayersName: UIStackView!
    
    var segueToGame = "goToGameController"
    var isPlayingWithAI = false

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapPlayWithAI(_ sender: UITapGestureRecognizer) {
        btnPlayWithAI.isHighlighted = true
        txtPlayerWithAIName.isHidden = false
        btnPlayWithFriend.isHighlighted = false
        stackViewPlayersName.isHidden = true
        isPlayingWithAI = true
        
    }
    
    
    @IBAction func onTapPlayWithFriend(_ sender: UITapGestureRecognizer) {
        btnPlayWithAI.isHighlighted = false
        btnPlayWithFriend.isHighlighted = true
        stackViewPlayersName.isHidden = false
        txtPlayerWithAIName.isHidden = true
        isPlayingWithAI = false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToGame,
           let gameVC = segue.destination as? GameViewController {
            gameVC.gameMode = isPlayingWithAI ? .PlayerVsAI : .PlayerVsPlayer
            
            if isPlayingWithAI {
                gameVC.player1Name = txtPlayerWithAIName.text ?? "Cross"
                gameVC.player2Name = "AI"
            } else {
                gameVC.player1Name = txtPlayer1Name.text ?? "Cross"
                gameVC.player2Name = txtPlayer2Name.text ?? "Nought"
            }
        }
    }

    
    @IBAction func onPlay(_ sender: UITapGestureRecognizer) {
            
            if btnPlayWithFriend.isHighlighted {
                // Play with a friend option is selected
                guard let player1Name = txtPlayer1Name.text, !player1Name.isEmpty,
                      let player2Name = txtPlayer2Name.text, !player2Name.isEmpty else {

                    showAlert(message: "Please enter names for both players.")
                    return
                }
                performSegue(withIdentifier: segueToGame, sender: nil)
            } else if btnPlayWithAI.isHighlighted {
                // Play with AI option is selected
                guard let playerWithAIName = txtPlayerWithAIName.text, !playerWithAIName.isEmpty else {

                    showAlert(message: "Please enter your name.")
                    return
                }
                performSegue(withIdentifier: segueToGame, sender: nil)
            } else {
                showAlert(message: "Please select a game option.")
            }

        }
        
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Warning!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
