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

    var modelName: String = ""
    var fileExtension: String = ""
    var thumbImage: UIImage!
    var title: String = ""
    
    var viewController: CameraViewController?

    override init() {
        super.init()
        self.name = "Virtual object root node"
    }
    
    init(modelName: String, fileExtension: String, thumbImageFilename: String, title: String) {
        super.init()
        self.name = "Virtual object root node"
        self.modelName = modelName
        self.fileExtension = fileExtension
        self.thumbImage = UIImage(named: thumbImageFilename)
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadModel() {
        guard let virtualObjectScene = SCNScene(named: "\(modelName).\(fileExtension)", inDirectory: "Models.scnassets/\(modelName)") else {
            return
        }
        
        let wrapperNode = SCNNode()
        
        for child in virtualObjectScene.rootNode.childNodes {

            let defaults = UserDefaults.standard
            if defaults.bool(forKey: .changeColor) {
                child.geometry?.firstMaterial?.diffuse.contents = UIColor.red
            }
            wrapperNode.addChildNode(child)
        }
        self.addChildNode(wrapperNode)
    }
    
    func unloadModel() {
        self.removeFromParentNode()
        for child in self.childNodes {
                child.removeFromParentNode()
        }
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
