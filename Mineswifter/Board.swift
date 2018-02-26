//
//  Board.swift
//  Mineswifter
//
//  Created by Krishnaiah, Jahnavi (Contractor) on 12/4/17.
//  Copyright © 2017 Krishnaiah, Jahnavi (Contractor). All rights reserved.
//

import Foundation

class Board {
    let size:Int
    var totalMines:Int = 0
    var squares:[[Square]] = []
    
    init(size:Int) {
        self.size = size
        
        for row in 0 ..< size  {
            var squaresRow:[Square] = []
            for col in 0 ..< size {
                let square = Square(row: row, col: col)
                squaresRow.append(square)
            }
            squares.append(squaresRow)
        }
    }
    
    func resetBoard() {
        totalMines = 0
        for row in 0 ..< size {
            for col in 0 ..< size {
                squares[row][col].isSquareRevealed = false
                squares[row][col].isMineLocated = false
                self.calculateIsMineLocationForSquare(square: squares[row][col])
            }
        }
        
        for row in 0 ..< size {
            for col in 0 ..< size {
                self.numOfNeighbouringMinesForSquare(square: squares[row][col])
            }
        }
    }
    
    func calculateIsMineLocationForSquare(square: Square){
        if (arc4random()%10) == 0
        {
            square.isMineLocated = true
            self.totalMines += 1
        }
           
    }
    
    func numOfNeighbouringMinesForSquare(square:Square) {
        let neighbouringSquares = self.totalNumOfNeighbours(square: square)
        var totalNeighbouringMines:Int = 0
        for neighbour in neighbouringSquares {
            if neighbour.isMineLocated {
                totalNeighbouringMines += 1
            }
        }
        square.numOfNeighbouringMines = totalNeighbouringMines
        if square.numOfNeighbouringMines == 0
        {
            square.label = ""
        }
        else
        {
            square.label = "\(square.numOfNeighbouringMines)"
        }
    }
    
    func totalNumOfNeighbours(square: Square) -> [Square] {
        var neighbouringSquares:[Square] = []
        let adjacentNeighboursOffset = [(-1,1),(0,1),(1,1),(-1,0),(1,0),(-1,-1),(0,-1),(1,-1)]
        for (rowOffset,colOffset) in adjacentNeighboursOffset {
            let neighbouringSquare: Square? = self.getTileAtLocation(row: (square.row + rowOffset), col: (square.col + colOffset))
            if let neighbouringSquare = neighbouringSquare {
                neighbouringSquares.append(neighbouringSquare)
            }
        }
        return neighbouringSquares
    }   
    
    func getTileAtLocation(row: Int, col: Int) -> Square? {
        if row >= 0 && row < size && col >= 0 && col < size {
            return squares[row][col]
        } else {
            return nil
        }
    }
    
    
}
