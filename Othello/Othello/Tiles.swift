//
//  Tiles.swift
//  Othello
//
//  Created by Jonathan Pappas on 12/15/21.
//

import Foundation
import SpriteKit

enum Teams {
    case none, white, black
}

class Tile: SKSpriteNode {
    var circle = SKShapeNode(circleOfRadius: 40)
    var team: Teams = .none
    
    func flipToWhite() {
        team = .white
        circle.fillColor = .white
    }
    func flipToBlack() {
        team = .black
        circle.fillColor = .black
    }
    
    static func Make(x: Int, y: Int) -> Tile {
        let tile = Tile(color: .white, size: CGSize.init(width: 100, height: 100))
        tile.color = NSColor(red: 0.3, green: 0.6, blue: 0.2, alpha: 1)
        tile.position = CGPoint(x: x * 110, y: y * 110)
        tile.name = "\(x) \(y)"
        
        tile.addChild(tile.circle)
        tile.circle.strokeColor = .clear
        tile.circle.fillColor = .clear
        
        return tile
    }
}
extension Othello {
    func tileAt(x: Int, y: Int) -> Tile {
        return tiles[x-1][y-1]
    }
    func isOppositeColor(x: Int, y: Int) -> Bool {
        if x == 0 || y == 0 { return false }
        if x > dimensions.x || y > dimensions.y { return false }
        
        if whitesTurn, tileAt(x: x, y: y).team == .black {
            return true
        } else if !whitesTurn, tileAt(x: x, y: y).team == .white {
            return true
        }
        return false
    }
    func isSameColor(x: Int, y: Int) -> Bool {
        if x == 0 || y == 0 { return false }
        if x > dimensions.x || y > dimensions.y { return false }
        
        if whitesTurn, tileAt(x: x, y: y).team == .white {
            return true
        } else if !whitesTurn, tileAt(x: x, y: y).team == .black {
            return true
        }
        return false
    }
//    func hitEdge(x: Int, y: Int) -> Bool {
//        return x == 0 || y == 0 || x > dimensions.x || y > dimensions.y
//    }
}
