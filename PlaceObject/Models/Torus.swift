//
//  Torus.swift
//  PlaneDetection
//
//  Created by Andrei Momot on 11/6/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit
import SceneKit

class Torus: VirtualObject {
    
    override init() {
        let torus = SCNTorus(ringRadius: 0.1, pipeRadius: 0.025)
        torus.materials.first?.diffuse.contents = UIColor.white
        let node = SCNNode(geometry: torus)
        super.init(model: node, thumbImageFilename: "torus", title: "Torus")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
