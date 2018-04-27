//
//  AnimatedKid.swift
//  ItsRainingKids
//
//  Created by Boyko Ivan on 4/24/18.
//  Copyright © 2018 KanabeBoyko. All rights reserved.
//

import Foundation
import SpriteKit

class AnimatedKid : SKSpriteNode{
    private var walkingFrames: [SKTexture] = []
    let animatedAtlas = SKTextureAtlas(named: "animation")
    var walkFrames: [SKTexture] = []
    
    
    init(_position: CGPoint){
        let numImages = animatedAtlas.textureNames.count
        for i in 1...numImages {
            let textureName = "image\(i)"
            walkFrames.append(animatedAtlas.textureNamed(textureName))
        }
        walkingFrames = walkFrames
        let firstFrameTexture = walkingFrames[0]
        super.init(texture: firstFrameTexture, color: .clear, size: CGSize(width: firstFrameTexture.size().width * 10, height: firstFrameTexture.size().height * 10))
        position = _position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func Animate() {
        run(SKAction.repeatForever(
            SKAction.animate(with: walkingFrames,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)),
                 withKey:"animation")
    }
}
