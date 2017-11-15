//
//  Geosphere.swift
//  PlaneDetection
//
//  Created by Andrei Momot on 11/6/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import Foundation

class Geosphere: VirtualObject {
    
    override init() {
        super.init(modelName: "geosphere", fileExtension: "scn", thumbImageFilename: "geosphere", title: "Geosphere")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
