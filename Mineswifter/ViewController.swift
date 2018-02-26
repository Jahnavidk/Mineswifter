//
//  ViewController.swift
//  Mineswifter
//
//  Created by Krishnaiah, Jahnavi (Contractor) on 12/4/17.
//  Copyright © 2017 Krishnaiah, Jahnavi (Contractor). All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let BOARD_SIZE:Int = 10
    var board:Board
    var squareButtons:[[SquareButton]] = []
    var timer: Timer?

    @IBOutlet weak var totalMoves: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var totalMines: UILabel!
    @IBOutlet weak var boardView: UIView!
    
    var moves:Int = 0 {
        didSet {
            self.totalMoves.text = "Moves: \(moves)"
            self.totalMoves.sizeToFit()
        }
    }
    
    var time:Int = 0 {
        didSet {
            self.totalTime.text = "Time: \(time)"
            self.totalTime.sizeToFit()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.board = Board(size: BOARD_SIZE)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeBoard()
        self.newGamePressed()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newGamePressed() {
        self.resetBoard()
        self.endCurrentTime()
        self.time = 0
        self.moves = 0
        self.totalMines.text = "Mines: \(board.totalMines)"
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerOneSecond), userInfo: nil, repeats: true)
    }
    
    @objc func timerOneSecond() {
        self.time += 1
    }
    
    func initializeBoard() {
        for row in 0 ..< board.size {
            var sqBtn:[SquareButton] = []
            for col in 0 ..< board.size {
                let square = board.squares[row][col]
                self.boardView.frame.size.height = self.boardView.frame.width
                let squareSize = self.boardView.frame.width / CGFloat(BOARD_SIZE)
                let squareButton = SquareButton(square: square, squareSize: squareSize, squareMargin: 0)
                squareButton.setTitleColor(UIColor.darkGray, for: .normal)
                squareButton.addTarget(self, action: #selector(ViewController.forButtonPressed(_:)), for: .touchUpInside)
                self.boardView.addSubview(squareButton)
                sqBtn.append(squareButton)
            }
            self.squareButtons.append(sqBtn)
        }
    }
    
    @objc func forButtonPressed(_ sender: SquareButton) {
        if(!sender.square.isSquareRevealed) {
            self.moves += 1
        
            if sender.square.isMineLocated {
                self.minePressed()
            } else if sender.square.label == "" {
                self.checkBlankSquares(squareToCheck: sender.square)
            }
            self.buttonPressFunc(square: sender.square)
        }
    }
    
    func buttonPressFunc(square: Square)
    {
        square.isSquareRevealed = true
        squareButtons[square.row][square.col].setTitle("\(self.getLabelText(square: square))", for: .normal)
    }
    
    func checkBlankSquares(squareToCheck:Square)
    {
        for square in board.totalNumOfNeighbours(square: squareToCheck)
        {
            if !square.isMineLocated && !square.isSquareRevealed
            {
                self.buttonPressFunc(square: square)
                if square.label == "" {
                    self.checkBlankSquares(squareToCheck: square)
                }
            }
        }
    }
    
    func minePressed() {
        self.endCurrentTime()
        let alertView = UIAlertController.init(title: "BOOM !!!", message: "Looks like you tapped on a mine", preferredStyle: .alert)
        alertView.addAction(UIAlertAction.init(title: "New Game", style: .default, handler: { action in
            self.newGamePressed()
        }))
        self.present(alertView, animated: false, completion: nil)
    }
    
    func resetBoard() {
        self.board.resetBoard()
        for row in 0 ..< BOARD_SIZE {
            for col in 0 ..< BOARD_SIZE {
                squareButtons[row][col].setTitle("[X]", for: .normal)
            }
        }
    }
    
    func endCurrentTime() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func getLabelText(square: Square) -> String {
        if !square.isMineLocated {
            return square.label
        } else {
            return "M"
        }
    }
}

