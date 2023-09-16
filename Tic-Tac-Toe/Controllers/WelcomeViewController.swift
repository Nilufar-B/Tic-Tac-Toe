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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
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
    
}
