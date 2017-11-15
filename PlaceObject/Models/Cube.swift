//
//  Cube.swift
//  PlaneDetection
//
//  Created by Andrei Momot on 11/1/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import Foundation

class Cube: VirtualObject {
    
    override init() {
        super.init(modelName: "cube", fileExtension: "scn", thumbImageFilename: "cube", title: "Cube")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

