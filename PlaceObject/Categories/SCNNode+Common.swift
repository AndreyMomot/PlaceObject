//
//  SCNNode+Common.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/30/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import Foundation
import ARKit

// MARK: - SCNNode extension

extension SCNNode {
    
    func setUniformScale(_ scale: Float) {
        self.scale = SCNVector3Make(scale, scale, scale)
    }
    
    func renderOnTop() {
        self.renderingOrder = 2
        if let geom = self.geometry {
            for material in geom.materials {
                material.readsFromDepthBuffer = false
            }
        }
        for child in self.childNodes {
            child.renderOnTop()
        }
    }
}

// MARK: - Simple Geometries

func createCrossNode(size: CGFloat = 0.01, color: UIColor = UIColor.green, horizontal: Bool = true, opacity: CGFloat = 1.0) -> SCNNode {
    
    // Create a size x size m plane and put a grid texture onto it.
    let planeDimension = size
    
    var fileName = ""
    switch color {
    case UIColor.blue:
        fileName = "crosshair_blue"
    case UIColor.yellow:
        fallthrough
    default:
        fileName = "crosshair_yellow"
    }
    
    let path = Bundle.main.path(forResource: fileName, ofType: "png")!
    let image = UIImage(contentsOfFile: path)
    
    let planeNode = SCNNode(geometry: createSquarePlane(size: planeDimension, contents: image))
    if let material = planeNode.geometry?.firstMaterial {
        material.ambient.contents = UIColor.black
        material.lightingModel = .constant
    }
    
    if horizontal {
        planeNode.eulerAngles = SCNVector3Make(Float.pi / 2.0, 0, Float.pi) // Horizontal.
    } else {
        planeNode.constraints = [SCNBillboardConstraint()] // Facing the screen.
    }
    
    let cross = SCNNode()
    cross.addChildNode(planeNode)
    cross.opacity = opacity
    return cross
}

func createSquarePlane(size: CGFloat, contents: AnyObject?) -> SCNPlane {
    let plane = SCNPlane(width: size, height: size)
    plane.materials = [SCNMaterial.material(withDiffuse: contents)]
    return plane
}

func createPlane(size: CGSize, contents: AnyObject?) -> SCNPlane {
    let plane = SCNPlane(width: size.width, height: size.height)
    plane.materials = [SCNMaterial.material(withDiffuse: contents)]
    return plane
}
