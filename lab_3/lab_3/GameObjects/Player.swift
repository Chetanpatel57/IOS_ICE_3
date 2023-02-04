//
//  Player.swift
//  Lab_1
//
//  Created by Chetan Patel on 2023-01-22.
//

import GameplayKit
import SpriteKit

class Player : GameObject
{
    init()
    {
        super.init(imageString: "plane", initialScale: 2.0)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:)has not been impelented")
    }
    
    override func Start() {
        zPosition = Layer.plane.rawValue
        Reset()
    }
    
    override func Update() {
        CheckBounds()
    }
    
    override func CheckBounds() {
        if(position.x <= -320){
            position.x = -320
        }
        if(position.x >= 320){
            position.x = 320
        }
    }
    
    override func Reset() {
        position.y = -640
    }
    
    func TouchMove(newPos: CGPoint){
        position = newPos
    }
}
