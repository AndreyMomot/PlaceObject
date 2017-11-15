//
//  Cone.swift
//  PlaneDetection
//
//  Created by Andrei Momot on 11/6/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import Foundation

class Cone: VirtualObject {
    
    override init() {
        super.init(modelName: "cone", fileExtension: "scn", thumbImageFilename: "cone", title: "Cone")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
