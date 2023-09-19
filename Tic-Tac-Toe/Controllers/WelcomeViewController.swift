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
    
    @IBOutlet weak var stackViewPlayersName: UIStackView!
    
    var mySegue = "goToGameController"
    var isPlayingWithAI = false

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapPlayWithAI(_ sender: UITapGestureRecognizer) {
        btnPlayWithAI.isHighlighted = true
        btnPlayWithFriend.isHighlighted = false
        isPlayingWithAI = true
        
    }
    
    
    @IBAction func onTapPlayWithFriend(_ sender: UITapGestureRecognizer) {
        btnPlayWithAI.isHighlighted = false
        btnPlayWithFriend.isHighlighted = true
        stackViewPlayersName.isHidden = false
        isPlayingWithAI = false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == mySegue,
           let gameVC = segue.destination as? GameViewController {
            // Передайте имена игроков в GameViewController
            if btnPlayWithFriend.isHighlighted {
                gameVC.player1Name = txtPlayer1Name.text ?? "Cross"
                gameVC.player2Name = txtPlayer2Name.text ?? "Nought"
            }
        }
    }
    
    @IBAction func onPlay(_ sender: UITapGestureRecognizer) {
      
            // Check if the "Play with Friend" button is selected
            if btnPlayWithFriend.isHighlighted {
                // Ensure both player names are entered
                guard let player1Name = txtPlayer1Name.text, !player1Name.isEmpty,
                      let player2Name = txtPlayer2Name.text, !player2Name.isEmpty else {
                    
                    showAlert(message: "Please enter name for both players.")
                    return
                }
             performSegue(withIdentifier: mySegue, sender: nil)
            }
        }
        
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
