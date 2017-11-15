//
//  Sphere.swift
//  PlaneDetection
//
//  Created by Andrei Momot on 11/2/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import Foundation

class Sphere: VirtualObject {
    
    override init() {
        super.init(modelName: "sphere", fileExtension: "scn", thumbImageFilename: "sphere", title: "Sphere")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
