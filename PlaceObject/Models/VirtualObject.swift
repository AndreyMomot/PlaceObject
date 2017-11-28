//
//  VirtualObject.swift
//  PlaneDetection
//
//  Created by Andrei Momot on 11/1/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class VirtualObject: SCNNode {

    var model: SCNNode!
//    var fileExtension: String = ""
    var thumbImage: UIImage!
    var title: String = ""
    
    var viewController: CameraViewController?

    override init() {
        super.init()
        self.name = "Virtual object root node"
    }
    
    init(model: SCNNode, thumbImageFilename: String, title: String) {
        super.init()
        self.name = "Virtual object root node"
        self.model = model
        self.thumbImage = UIImage(named: thumbImageFilename)
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadModel() {

            let defaults = UserDefaults.standard
            if defaults.bool(for: .changeColor) {
                model.geometry?.firstMaterial?.diffuse.contents = UIColor.red
            } else {
                model.geometry?.firstMaterial?.diffuse.contents = UIColor.white
        }
        self.addChildNode(model)
    }
    
    func unloadModel() {
        self.removeFromParentNode()
    }
    
    func translateBasedOnScreenPos(_ pos: CGPoint, instantly: Bool, infinitePlane: Bool) {
        
        guard let controller = viewController else {
            return
        }
        
        let result = controller.worldPositionFromScreenPosition(pos, objectPos: self.position, infinitePlane: infinitePlane)
        
        controller.moveVirtualObjectToPosition(result.position, instantly, !result.hitAPlane)
    }
}

extension VirtualObject {
    
    static func isNodePartOfVirtualObject(_ node: SCNNode) -> Bool {
        if node.name == "Virtual object root node" {
            return true
        }
        
        if node.parent != nil {
            return isNodePartOfVirtualObject(node.parent!)
        }
        
        return false
    }
    
    static let availableObjects: [VirtualObject] = [
        Cube(),
        Sphere(),
        Pyramid(),
        Capsule(),
        Cone(),
        Cylinder(),
        Torus(),
        Geosphere(),
        Tube()
    ]
}
