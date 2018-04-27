//
//  SpawnManager.swift
//  ItsRainingKids
//
//  Created by Boyko Ivan on 3/14/18.
//  Copyright © 2018 KanabeBoyko. All rights reserved.
//

import Foundation
import SpriteKit

class SpawnManager
{
    weak var sceneRef: GameScene?
    var spawnLocation: CGPoint
    var standardDeviation: UInt32
    
    let FactoryKid = KidFactory()
    
    init(sRef: GameScene) {
        sceneRef = sRef
        spawnLocation = CGPoint(x: sceneRef!.size.width/2, y: sceneRef!.size.height/2)
        standardDeviation = UInt32(sceneRef!.size.width/4 - sceneRef!.size.width/10)
    }
    
    func spawnKid() -> Kid{
        let newKid = FactoryKid.createKid(specificType: nil) //uses the factory to generate a kid
        newKid.position = CGPoint(x: spawnLocation.x, y: spawnLocation.y)
        newKid.screenBounds = UIScreen.main.bounds
        newKid.screenBounds.origin = spawnLocation
        return newKid
    }
    
}
