//
//  File name: SquareButton.swift.
//  It was created on 12/4/17.
        
//  Copyright © 2017 Krishnaiah, Jahnavi . All rights reserved.

import UIKit

class SquareButton : UIButton {
    let squareSize:CGFloat
    let squareMargin:CGFloat
    var square:Square
    
    init(square:Square, squareSize:CGFloat, squareMargin: CGFloat) {
        self.square = square
        self.squareSize = squareSize
        self.squareMargin = squareMargin
        let x = CGFloat(self.square.col) * (squareSize + squareMargin)
        let y = CGFloat(self.square.row) * (squareMargin + squareSize)
        let squareFrame = CGRect(x: x, y: y, width: squareSize, height: squareSize)
        super.init(frame: squareFrame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
