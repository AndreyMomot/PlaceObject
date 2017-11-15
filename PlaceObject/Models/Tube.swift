//
//  Tube.swift
//  PlaneDetection
//
//  Created by Andrei Momot on 11/6/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import Foundation

class Tube: VirtualObject {
    
    override init() {
        super.init(modelName: "tube", fileExtension: "scn", thumbImageFilename: "tube", title: "Tube")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
