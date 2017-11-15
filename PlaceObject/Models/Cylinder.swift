//
//  Cylinder.swift
//  PlaneDetection
//
//  Created by Andrei Momot on 11/6/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import Foundation

class Cylinder: VirtualObject {
    
    override init() {
        super.init(modelName: "cylinder", fileExtension: "scn", thumbImageFilename: "cylinder", title: "Cylinder")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

