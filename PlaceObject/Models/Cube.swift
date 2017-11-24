//
//  Cube.swift
//  PlaneDetection
//
//  Created by Andrei Momot on 11/1/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit
import SceneKit

class Cube: VirtualObject {
    
    override init() {
        let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        cube.materials.first?.diffuse.contents = UIColor.white
        let node = SCNNode(geometry: cube)
        super.init(model: node, thumbImageFilename: "cube", title: "Cube")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

