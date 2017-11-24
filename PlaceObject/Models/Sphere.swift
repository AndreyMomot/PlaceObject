//
//  Sphere.swift
//  PlaneDetection
//
//  Created by Andrei Momot on 11/2/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit
import SceneKit

class Sphere: VirtualObject {
    
    override init() {
        let sphere = SCNSphere(radius: 0.05)
        sphere.segmentCount = 24
        sphere.materials.first?.diffuse.contents = UIColor.white
        let node = SCNNode(geometry: sphere)
        super.init(model: node, thumbImageFilename: "sphere", title: "Sphere")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
