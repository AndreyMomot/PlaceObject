//
//  Geosphere.swift
//  PlaneDetection
//
//  Created by Andrei Momot on 11/6/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class Geosphere: VirtualObject {
    
    override init() {
        let sphere = SCNSphere(radius: 0.1)
        sphere.segmentCount = 12
        sphere.materials.first?.diffuse.contents = UIColor.white
        let node = SCNNode(geometry: sphere)
        super.init(model: node, thumbImageFilename: "geosphere", title: "Geosphere")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
