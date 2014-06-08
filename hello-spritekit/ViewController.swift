//
//  ViewController.swift
//  hello-spritekit
//
//  Created by Yasuharu Ozaki on 6/8/14.
//  Copyright (c) 2014 yasuharu.ozaki. All rights reserved.
//

import UIKit
import SpriteKit


class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()

        let hello = HelloScene(size: CGSizeMake(768,1024))

        let spriteView = self.view as SKView

        spriteView.presentScene(hello);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

