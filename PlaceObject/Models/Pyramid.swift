//
//  Pyramid.swift
//  PlaneDetection
//
//  Created by Andrei Momot on 11/2/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit
import SceneKit

class Pyramid: VirtualObject {
    
    override init() {
        let pyramid = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        pyramid.materials.first?.diffuse.contents = UIColor.white
        let node = SCNNode(geometry: pyramid)
        super.init(model: node, thumbImageFilename: "pyramid", title: "Pyramid")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

