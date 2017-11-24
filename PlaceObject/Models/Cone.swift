//
//  Cone.swift
//  PlaneDetection
//
//  Created by Andrei Momot on 11/6/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit
import SceneKit

class Cone: VirtualObject {
    
    override init() {
        let cone = SCNCone(topRadius: 0, bottomRadius: 0.05, height: 0.1)
        cone.materials.first?.diffuse.contents = UIColor.white
        let node = SCNNode(geometry: cone)
        super.init(model: node, thumbImageFilename: "cone", title: "Cone")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
