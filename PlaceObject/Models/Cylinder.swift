//
//  Cylinder.swift
//  PlaneDetection
//
//  Created by Andrei Momot on 11/6/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit
import SceneKit

class Cylinder: VirtualObject {
    
    override init() {
        let cylinder = SCNCylinder(radius: 0.05, height: 0.1)
        cylinder.materials.first?.diffuse.contents = UIColor.white
        let node = SCNNode(geometry: cylinder)
        super.init(model: node, thumbImageFilename: "cylinder", title: "Cylinder")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

