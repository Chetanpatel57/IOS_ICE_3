//
//  GameScene.swift
//  lab_3
//
//  Created by Chetan Patel on 2023-02-04.
//

import SpriteKit
import GameplayKit
import AVFoundation
import UIKit

let screeSize = UIScreen.main.bounds
var screenWidth: CGFloat?
var screenHeight: CGFloat?

class GameScene: SKScene {
    
    var ocean1: Ocean1?
    var ocean2: Ocean1?
    var player: Player?
    var island : Island?
    var clouds : [Cloud] = []
    
    override func sceneDidLoad() {
        
        screenWidth = frame.width
        screenHeight = frame.height
        
        
        name = "GAME"
        
        ocean1 = Ocean1()
        ocean1?.Reset()
        addChild(ocean1!)
        
        ocean2 = Ocean1()
        ocean2?.position.y = -627
        addChild(ocean2!)
        
        player = Player()
        addChild(player!)
        
        island = Island()
        addChild(island!)
        
        for _ in 0...2{
            let cloud: Cloud = Cloud()
            clouds.append(cloud)
            addChild(cloud)
        }
        
        let engineSound = SKAudioNode(fileNamed: "engine.mp3")
               addChild(engineSound)
               engineSound.autoplayLooped = true
               engineSound.run(SKAction.changeVolume(to: 0.5, duration: 0))
               
               
               // preload / prewarm impulse sounds
               do
               {
                   let sounds: [String] = ["thunder", "yay"]
                   for sound in sounds
                   {
                       let path: String = Bundle.main.path(forResource: sound, ofType: "mp3")!
                       let url:URL = URL(fileURLWithPath: path)
                       let avPlayer: AVAudioPlayer = try AVAudioPlayer(contentsOf: url)
                       avPlayer.prepareToPlay()
                   }
               }
               catch
               {
                   
               }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        player?.TouchMove(newPos: CGPoint(x: pos.x, y: -640))
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        player?.TouchMove(newPos: CGPoint(x: pos.x, y: -640))
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        player?.TouchMove(newPos: CGPoint(x: pos.x, y: -640))
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        ocean1?.Update()
        ocean2?.Update()
        player?.Update()
        island?.Update()
        CollisionManager.SquaredRadiusCheck(scene: self, object1: player!, object2: island!)
                
                // update each cloud in the clouds array
                for cloud in clouds
                {
                    cloud.Update()
                    CollisionManager.SquaredRadiusCheck(scene: self, object1: player!, object2: cloud)
                }
    }
}

