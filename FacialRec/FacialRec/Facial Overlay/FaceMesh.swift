//
//  FaceMesh.swift
//  FacialRec
//
//  Created by Lauren Gray on 1/14/20.
//  Copyright © 2020 Lauren Gray. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class FaceMesh: NSObject, VirtualContentController {
    
    var contentNode: SCNNode?
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let sceneView = renderer as? ARSCNView, anchor is ARFaceAnchor else {return nil}
        
        #if targetEnvironment(simulator)
        #error("ARKit is not supported in iOS Simulator. Connect a physical iOS device and select it as your Xcode run destination, or select Generic iOS Device as a build-only destination.")
        #else
        let faceGeometry = ARSCNFaceGeometry(device: sceneView.device!)!
        let material = faceGeometry.firstMaterial!
        
        material.diffuse.contents = #imageLiteral(resourceName: "wireframeTexture.png")
        material.lightingModel = .physicallyBased
        
        contentNode = SCNNode(geometry: faceGeometry)
        #endif
        return contentNode
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceGeometry = node.geometry as? ARSCNFaceGeometry, let faceAnchor = anchor as? ARFaceAnchor
            else {return}
        
        faceGeometry.update(from: faceAnchor.geometry)
    }
}
