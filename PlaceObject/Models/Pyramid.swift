//
//  Pyramid.swift
//  PlaneDetection
//
//  Created by Andrei Momot on 11/2/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import Foundation

class Pyramid: VirtualObject {
    
    override init() {
        super.init(modelName: "pyramid", fileExtension: "scn", thumbImageFilename: "pyramid", title: "Pyramid")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

