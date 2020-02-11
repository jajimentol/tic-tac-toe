//
//  SingleTurnCVC.swift
//  Sociable-Tic-Tac-Toe
//
//  Created by Sirius on 11.02.2020.
//  Copyright © 2020 Jaji. All rights reserved.
//

import UIKit

class SingleTurnCVC: UICollectionViewCell {
    
    @IBOutlet weak var turnLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func cellTapped(player: Int) {
        isUserInteractionEnabled = false
        if player == 1 {
            turnLabel.text = "X"
        } else {
            turnLabel.text = "O"
        }
    }
    
    func reset() {
        isUserInteractionEnabled = true
        turnLabel.text = ""
    }
}
