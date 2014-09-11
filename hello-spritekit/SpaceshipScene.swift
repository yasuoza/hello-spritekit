//
//  SpaceshipScene.swift
//  hello-spritekit
//
//  Created by Yasuharu Ozaki on 6/8/14.
//  Copyright (c) 2014 yasuharu.ozaki. All rights reserved.
//

import SpriteKit


class SpaceshipScene : SKScene {

    var contentCreated:Bool = false

    class func skRandf() -> CGFloat {
        return CGFloat(rand()) / CGFloat(RAND_MAX)
    }

    class func skRand(low : CGFloat, high : CGFloat) -> CGFloat {
        return skRandf() * (high - low) + low
    }

    override func didMoveToView(view: SKView!) {
        if (!self.contentCreated) {
            self.createSceneContent();
            self.contentCreated = true
        }
    }

    override func didSimulatePhysics() {
        self.enumerateChildNodesWithName("rock", usingBlock: {node, stop in
            if (node.position.y < 0) {
                node.removeFromParent()
            }
        })
    }

    func createSceneContent() {
        self.backgroundColor = SKColor.blackColor()
        self.scaleMode = .AspectFit
        let spaceship = self.newSpaceShip()
        spaceship.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 150)
        self.addChild(spaceship)

        let makeRocks = SKAction.sequence([
            SKAction.runBlock({
                    self.addRock()
                }),
            SKAction.waitForDuration(0.10, withRange:0.15)
            ])
        self.runAction(SKAction.repeatActionForever(makeRocks))
    }

    func addRock() {
        let rock = SKSpriteNode(color: SKColor.brownColor(), size: CGSizeMake(8, 8))
        rock.position = CGPointMake(SpaceshipScene.skRand(0.0, high: self.size.width) * 10, self.size.height-50)
        rock.name = "rock"
        rock.physicsBody = SKPhysicsBody(rectangleOfSize: rock.size)
        rock.physicsBody?.usesPreciseCollisionDetection = true
        self.addChild(rock)
    }

    func newSpaceShip() -> SKSpriteNode {
        let hull = SKSpriteNode(color: SKColor.grayColor(), size: CGSizeMake(64, 32))
        hull.physicsBody = SKPhysicsBody(rectangleOfSize: hull.size)
        hull.physicsBody?.dynamic = false

        let light1 = self.newLight()
        light1.position = CGPointMake(-28.0, 6.0)
        hull.addChild(light1)

        let light2 = self.newLight()
        light2.position = CGPointMake(28.0, 6.0)
        hull.addChild(light2)

        let hover = SKAction.sequence([
            SKAction.waitForDuration(1.0),
            SKAction.moveByX(100.0, y: 50.0, duration: 1.0),
            SKAction.waitForDuration(1.0),
            SKAction.moveByX(-100.0, y: -50, duration: 1.0)
            ]
        )
        hull.runAction(SKAction.repeatActionForever(hover))
        return hull
    }

    func newLight() -> SKSpriteNode {
        let light = SKSpriteNode(color: SKColor.yellowColor(), size: CGSizeMake(8, 8))
        let blink = SKAction.sequence([
            SKAction.fadeOutWithDuration(0.25),
            SKAction.fadeInWithDuration(0.25)
            ]
        )
        let blinkForever = SKAction.repeatActionForever(blink)
        light.runAction(blinkForever)
        return light
    }
}
