//
//  Ocean.swift
//  Lab_1
//
//  Created by Chetan Patel on 2023-01-22.
//

import GameplayKit
import SpriteKit

class Ocean1 : GameObject
{
    init()
    {
        super.init(imageString: "ocean", initialScale: 2.0)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)has not been impelented")
    }
    
    override func Start() {
        zPosition = Layer.ocean.rawValue
        verticalSpeed = 5.0
    }
    
    override func Update() {
        Move()
        CheckBounds()
    }
    
    override func CheckBounds() {
        if (position.y <= -2253)
        {
            Reset()
        }
    }
    
    override func Reset() {
        position.y = 2253
    }
    
    func Move() {
        position.y -= verticalSpeed!
    }
}
