//
//  GameViewController.swift
//  ItsRainingKids
//
//  Created by Kanabe Lucas A. on 2/28/18.
//  Copyright © 2018 KanabeBoyko. All rights reserved.
//  Rewritten with permission by Ivan Boyko

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = MenuScene(size: CGSize(width: 2048, height: 1536))
        let skView = self.view as! SKView
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
    
    
}
