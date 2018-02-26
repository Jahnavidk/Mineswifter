//
//  Square.swift
//  Mineswifter
//
//  Created by Krishnaiah, Jahnavi (Contractor) on 12/4/17.
//  Copyright © 2017 Krishnaiah, Jahnavi (Contractor). All rights reserved.
//

class Square {
    let row:Int
    let col:Int
    
    //assign default values so that it will change when the game is restarted
    var isSquareRevealed:Bool = false
    var isMineLocated:Bool = false
    var numOfNeighbouringMines:Int = 0
    var label:String = ""
    
    init(row:Int, col:Int) {
        //Store the row and col values of the square grid
        self.row = row
        self.col = col
    }
}
