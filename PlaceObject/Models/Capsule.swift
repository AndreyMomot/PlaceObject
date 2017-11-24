//
//  Capsule.swift
//  PlaneDetection
//
//  Created by Andrei Momot on 11/6/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit
import SceneKit

class Capsule: VirtualObject {
    
    override init() {
        let capsule = SCNCapsule(capRadius: 0.025, height: 0.1)
        capsule.materials.first?.diffuse.contents = UIColor.white
        let node = SCNNode(geometry: capsule)
        super.init(model: node, thumbImageFilename: "capsule", title: "Capsule")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
