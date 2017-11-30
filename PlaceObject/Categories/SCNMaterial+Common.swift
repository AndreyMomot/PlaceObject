//
//  SCNMaterial+Common.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/30/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import Foundation
import ARKit

// MARK: - SCNMaterial extensions

extension SCNMaterial {
    
    static func material(withDiffuse diffuse: Any?, respondsToLighting: Bool = true) -> SCNMaterial {
        let material = SCNMaterial()
        material.diffuse.contents = diffuse
        material.isDoubleSided = true
        if respondsToLighting {
            material.locksAmbientWithDiffuse = true
        } else {
            material.ambient.contents = UIColor.black
            material.lightingModel = .constant
            material.emission.contents = diffuse
        }
        return material
    }
}
