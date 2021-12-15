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
        backgroundColor = .black
        
        // Othello Label
        let othelloLabel = SKLabelNode.init(text: "Othello®")
        addChild(othelloLabel)
        othelloLabel.zPosition = 100
        othelloLabel.fontColor = .gray
        othelloLabel.fontName = ""
        othelloLabel.position = .init(x: 500, y: 935)
        othelloLabel.horizontalAlignmentMode = .center
        othelloLabel.setScale(2)
        othelloLabel.fontSize *= othelloLabel.xScale
        othelloLabel.setScale(1)
        
        // Turn Label
        addChild(othello.turnLabel)
        othello.turnLabel.zPosition = 100
        othello.turnLabel.fontColor = .white
        othello.turnLabel.fontName = ""
        othello.turnLabel.position = .init(x: 500, y: 10)
        othello.turnLabel.horizontalAlignmentMode = .center
        othello.turnLabel.setScale(2)
        othello.turnLabel.fontSize *= othello.turnLabel.xScale
        othello.turnLabel.setScale(1)
        
        // Create the tiles and references
        let boardNode = SKNode()
        othello.tiles = .init(repeating: [], count: othello.dimensions.x)
        for x in 1...othello.dimensions.x {
            for y in 1...othello.dimensions.y {
                let tile = Tile.Make(x: x, y: y)
                boardNode.addChild(tile)
                othello.tiles[x - 1].append(tile)
            }
        }
        addChild(boardNode)
        
        // Reposition the Grid so that it fits and is centered no matter what dimensions it is
        var perfect = boardNode.calculateAccumulatedFrame()
        let maximum = max(perfect.width, perfect.height)
        boardNode.setScale(850 / maximum)
        perfect = boardNode.calculateAccumulatedFrame()
        // Center the grid
        boardNode.position.x = 500 - (perfect.width/2)
        boardNode.position.y = 500 - (perfect.height/2)
        // The grid was off by half a tile
        boardNode.position.x -= 60 * boardNode.xScale
        boardNode.position.y -= 60 * boardNode.xScale
    }
    
    override func mouseDown(with event: NSEvent) {
        // Figure out if you will tap a node with a name of "0 5" or "8 8" or something
        let nodesTapped = nodes(at: event.location(in: self))
        for i in nodesTapped {
            if let nodeName = i.name {
                let splitName = nodeName.split(separator: " ")
                if let x = Int(splitName[0]), let y = Int(splitName[1]) {
                    othello.tapped(x: x, y: y, tile: i as! Tile)
                    
                    if othello.whitesTurn {
                        othello.turnLabel.text = "White's Turn"
                    } else {
                        othello.turnLabel.text = "Black's Turn"
                    }
                    
                    return
                }
            }
        }
    }
    
}
