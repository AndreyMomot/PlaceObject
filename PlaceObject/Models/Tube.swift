//
//  Tube.swift
//  PlaneDetection
//
//  Created by Andrei Momot on 11/6/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit
import SceneKit

class Tube: VirtualObject {
    
    override init() {
        let tube = SCNTube(innerRadius: 0.0125, outerRadius: 0.025, height: 0.1)
        tube.materials.first?.diffuse.contents = UIColor.white
        let node = SCNNode(geometry: tube)
        super.init(model: node, thumbImageFilename: "tube", title: "Tube")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
