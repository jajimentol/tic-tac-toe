//
//  ViewController.swift
//  Sociable-Tic-Tac-Toe
//
//  Created by Sirius on 11.02.2020.
//  Copyright © 2020 Jaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var layout = UICollectionViewFlowLayout()
    
    var player1Actions: [Int] = []
    var player2Actions: [Int] = []
    
    var turn: Bool = true {
        willSet {
            if newValue {
                player2Label.textColor = UIColor.darkGray
                player1Label.textColor = UIColor.green
            } else {
                player2Label.textColor = UIColor.green
                player1Label.textColor = UIColor.darkGray
            }
        }
    }
    
    var reset: Bool = false {
        willSet {
            if newValue {
                collectionView.reloadData()
                player1Actions = []
                player2Actions = []
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupCollectionView()
        player1Label.textColor = UIColor.green
    }

    func setupCollectionView() {
        
        
        let width = (collectionView.frame.size.width / 9)
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        
        collectionView.register(UINib(nibName: "SingleTurnCVC", bundle: nil), forCellWithReuseIdentifier: "SingleTurnCVC")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.isScrollEnabled = false
        
        collectionView.layer.borderWidth = 0.5
        collectionView.layer.borderColor = UIColor.darkGray.cgColor
        
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 81
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleTurnCVC", for: indexPath) as? SingleTurnCVC {
            if reset {
                cell.reset()
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        reset = false
        if turn {
            player1Actions.append(indexPath.item)
        } else {
            player2Actions.append(indexPath.item)
        }
        if let cell = collectionView.cellForItem(at: indexPath) as? SingleTurnCVC {
            cell.cellTapped(player: turn ? 1 : 2)
        }
        checkWinCondition(item: indexPath.item)
    }
}

extension ViewController { //Win Conditions
    
    func checkWinCondition(item: Int) {
        
        if checkVerticalWin(item: item) || checkHorizontalWin(item: item) || checkIsometricWin(item: item) {
            let alertController = UIAlertController(title: "Game ended.",
                                                    message: turn ? "Player 1 has won the game!" : "Player 2 has won the game!" , preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Reset", style: .default, handler: { [weak self] (action) in
                guard let strongSelf = self else { return }
                strongSelf.reset.toggle()
                
            })
            alertController.addAction(okAction)
            present(alertController, animated: false, completion: nil)
        }
        turn.toggle()
    }
    
    func checkVerticalWin(item: Int) -> Bool {
        if turn {
            if player1Actions.contains(item - 9) && player1Actions.contains(item - 18){
                return true
            } else if player1Actions.contains(item - 9) && player1Actions.contains(item + 9) {
                return true
            } else if player1Actions.contains(item + 9) && player1Actions.contains(item + 18) {
                return true
            }
        } else {
            if player2Actions.contains(item - 9) && player2Actions.contains(item - 18){
                return true
            } else if player2Actions.contains(item - 9) && player2Actions.contains(item + 9) {
                return true
            } else if player2Actions.contains(item + 9) && player2Actions.contains(item + 18) {
                return true
            }
        }
        return false
    }
    
    func checkHorizontalWin(item: Int) -> Bool {
        if turn {
            if player1Actions.contains(item - 1) && player1Actions.contains(item - 2){
                return true
            } else if player1Actions.contains(item + 1) && player1Actions.contains(item + 2) {
                return true
            } else if player1Actions.contains(item + 1) && player1Actions.contains(item - 1) {
                return true
            }
        } else {
            if player2Actions.contains(item - 1) && player2Actions.contains(item - 2){
                return true
            } else if player2Actions.contains(item + 1) && player2Actions.contains(item + 2) {
                return true
            } else if player2Actions.contains(item + 1) && player2Actions.contains(item - 1) {
                return true
            }
        }
        return false
    }
    
    func checkIsometricWin(item: Int) -> Bool {
        if turn {
            if player1Actions.contains(item - 10) && player1Actions.contains(item - 20){
                return true
            } else if player1Actions.contains(item + 10) && player1Actions.contains(item + 20) {
                return true
            } else if player1Actions.contains(item + 8) && player1Actions.contains(item + 16) {
                return true
            } else if player1Actions.contains(item - 8 ) && player1Actions.contains(item - 16) {
                return true
            } else if player1Actions.contains(item + 8) && player1Actions.contains(item - 8) {
                return true
            } else if player1Actions.contains(item + 10) && player1Actions.contains(item - 10) {
                return true
            }
        } else {
            if player2Actions.contains(item - 10) && player2Actions.contains(item - 20){
                return true
            } else if player2Actions.contains(item + 10) && player2Actions.contains(item + 20) {
                return true
            } else if player2Actions.contains(item + 8) && player2Actions.contains(item + 16) {
                return true
            } else if player2Actions.contains(item - 8 ) && player2Actions.contains(item - 16) {
                return true
            } else if player2Actions.contains(item + 8) && player2Actions.contains(item - 8) {
                return true
            } else if player2Actions.contains(item + 10) && player2Actions.contains(item - 10) {
                return true
            }
        }
        return false
    }
    
}
