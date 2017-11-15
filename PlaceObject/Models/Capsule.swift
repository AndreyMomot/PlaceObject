//
//  Capsule.swift
//  PlaneDetection
//
//  Created by Andrei Momot on 11/6/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import Foundation

class Capsule: VirtualObject {
    
    override init() {
        super.init(modelName: "capsule", fileExtension: "scn", thumbImageFilename: "capsule", title: "Capsule")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
