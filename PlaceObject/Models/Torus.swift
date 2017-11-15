//
//  Torus.swift
//  PlaneDetection
//
//  Created by Andrei Momot on 11/6/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import Foundation

class Torus: VirtualObject {
    
    override init() {
        super.init(modelName: "torus", fileExtension: "scn", thumbImageFilename: "torus", title: "Torus")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
