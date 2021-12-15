//
//  GameScene.swift
//  Othello
//
//  Created by Jonathan Pappas on 12/15/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var othello = Othello()
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        
        var boardNode = SKNode()
        
        for x in 1...othello.dimensions.x {
            for y in 1...othello.dimensions.y {
                let tile = SKSpriteNode.init(color: .init(red: 0.3, green: 0.6, blue: 0.2, alpha: 1), size: CGSize(width: 100, height: 100))
                tile.position.x = CGFloat(x) * 110
                tile.position.y = CGFloat(y) * 110
                boardNode.addChild(tile)
            }
        }
        
        addChild(boardNode)
        var perfect = boardNode.calculateAccumulatedFrame()
        let maximum = max(perfect.width, perfect.height)
        boardNode.setScale(950 / maximum)
        perfect = boardNode.calculateAccumulatedFrame()
        boardNode.position.x = 500 - (perfect.width/2)
        boardNode.position.y = 500 - (perfect.height/2)
        boardNode.position.x -= 55 * boardNode.xScale
        boardNode.position.y -= 55 * boardNode.xScale
    }
    
}

class Othello {
    var dimensions: (x: Int, y: Int) = (20, 30)
    var whitesTurn: Bool = true
    
    func tapped(x: Int, y: Int) {
        
    }
    
}
