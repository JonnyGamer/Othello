//
//  Othello.swift
//  Othello
//
//  Created by Jonathan Pappas on 12/15/21.
//

import Foundation
import SpriteKit

// Afterwards Challenges
// - Say Whose Turn it is
// - Highlight all Legal Moves

class Othello {
    var dimensions: (x: Int, y: Int) = (8, 8)
    var whitesTurn = true
    var tiles: [[Tile]] = []
    var moves = 0
    var turnLabel = SKLabelNode.init(text: "White's Turn")
    
    func tapped(x: Int, y: Int, tile: Tile) {
        //print("Tapped", x, y)
        //tileAt(x: x, y: y).alpha = 0.5
        
        if isValidMove(x: x, y: y) {
            if whitesTurn {
                tile.flipToWhite()
            } else {
                tile.flipToBlack()
            }
            
            moves += 1
            whitesTurn.toggle()
        }
        
    }
    
    func isValidMove(x: Int, y: Int) -> Bool {
        // Cannot place a tile on a tile that has already been placed on
        guard tileAt(x: x, y: y).team == .none else { return false }
        
        let directions: [(dx: Int, dy: Int)] = [(1,1),(1,0),(1,-1), (0,1),(0,-1), (-1,1),(-1,0),(-1,-1)]
        var flipsHappened = false
        for (dx, dy) in directions {
            
            var flippingCouldHappen = false
            var amount = 1
            while true {
                if isOppositeColor(x: x + dx * amount, y: y + dy * amount) {
                    flippingCouldHappen = true
                } else if flippingCouldHappen, isSameColor(x: x + dx * amount, y: y + dy * amount) {
                    flipsHappened = true
                    flipAt(x: x, y: y, dx: dx, dy: dy, amount: amount)
                    break
                } else {
                    break
                }
                amount += 1
            }
               
        }
        
        if flipsHappened {
            return true
        }
        if moves < 4 {
            return true
        }
        
        return false
    }
    
    func flipAt(x: Int, y: Int, dx: Int, dy: Int, amount: Int) {
        for i in 1...amount {
            let tile = tileAt(x: x + dx * i, y: y + dy * i)
            if whitesTurn {
                tile.flipToWhite()
            } else {
                tile.flipToBlack()
            }
        }
    }
    
}
