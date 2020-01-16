//
//  VirtualContent.swift
//  FacialRec
//
//  Created by Lauren Gray on 1/14/20.
//  Copyright © 2020 Lauren Gray. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

enum VirtualContentType: Int {
    case mesh
    func makeController() -> VirtualContentController {
            return FaceMesh()
    }
}

protocol VirtualContentController: ARSCNViewDelegate {
    var contentNode: SCNNode? {get set}
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode?
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor)

}
