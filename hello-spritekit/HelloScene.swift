//
//  HelloScene.swift
//  hello-spritekit
//
//  Created by Yasuharu Ozaki on 6/8/14.
//  Copyright (c) 2014 yasuharu.ozaki. All rights reserved.
//

import SpriteKit

class HelloScene : SKScene {

    var contentCreated:Bool = false

    override func didMoveToView(view: SKView!) {
        if (!self.contentCreated) {
            self.createSceneContent();
            self.contentCreated = true
        }
    }

    func createSceneContent() {
        self.backgroundColor = SKColor.blueColor()
        self.scaleMode = .AspectFit
        self.addChild(self.newHelloNode())
    }

    func newHelloNode() -> SKNode {
        let helloNode = SKLabelNode(fontNamed: "Chalkduster")
        helloNode.name = "helloNode"
        helloNode.text = "Hello, World!"
        helloNode.fontSize = 42
        helloNode.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))
        return helloNode
    }

    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        let helloNode = self.childNodeWithName("helloNode")

        if (!helloNode) {
            return
        }

        helloNode.name = nil
        let moveUp = SKAction.moveByX(0, y: 100.0, duration: 0.5)
        let zoom = SKAction.scaleTo(2.0, duration: 0.25)
        let pause = SKAction.waitForDuration(0.5)
        let fadeAway = SKAction.fadeOutWithDuration(0.25)
        let remove = SKAction.removeFromParent()
        let moveSequence = SKAction.sequence([moveUp, zoom, pause, fadeAway, remove])
//        helloNode.runAction(moveSequence)
        helloNode.runAction(moveSequence, completion: {
            let spaceshipScene = SpaceshipScene(size: self.size)
            let doors = SKTransition.doorsOpenVerticalWithDuration(0.5)
            self.view.presentScene(spaceshipScene, transition: doors)
            }
        )
    }
}
