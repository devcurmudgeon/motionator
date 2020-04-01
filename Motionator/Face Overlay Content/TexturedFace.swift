/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Displays the 3D face mesh geometry provided by ARKit, with a static texture.
*/

import ARKit
import SceneKit
import F53OSC

class TexturedFace: NSObject, VirtualContentController {

    var contentNode: SCNNode?
    
    /// - Tag: CreateARSCNFaceGeometry
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let sceneView = renderer as? ARSCNView,
            anchor is ARFaceAnchor else { return nil }
        
        #if targetEnvironment(simulator)
        #error("ARKit is not supported in iOS Simulator. Connect a physical iOS device and select it as your Xcode run destination, or select Generic iOS Device as a build-only destination.")
        #else
        let faceGeometry = ARSCNFaceGeometry(device: sceneView.device!)!
        let material = faceGeometry.firstMaterial!
        
        material.diffuse.contents = #imageLiteral(resourceName: "wireframeTexture") // Example texture map image.
        material.lightingModel = .physicallyBased
        
        contentNode = SCNNode(geometry: faceGeometry)
        #endif
        return contentNode
    }
    
    /// - Tag: ARFaceGeometryUpdate
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceGeometry = node.geometry as? ARSCNFaceGeometry,
            let faceAnchor = anchor as? ARFaceAnchor
            else { return }
        
        faceGeometry.update(from: faceAnchor.geometry)

        let transform = faceAnchor.transform
        let sceneView = renderer as! ARSCNView
        let frame = sceneView.session.currentFrame

        let proj = frame!.camera.projectionMatrix
        let view = frame!.camera.viewMatrix(for: UIInterfaceOrientation.portrait)
        let proj_view = simd_mul(proj, view)
        let mvp = simd_mul(proj_view, transform)
        let faceMatrix = SCNMatrix4(mvp)
        let faceNode = SCNNode()
        faceNode.setWorldTransform(faceMatrix)
        let euler = faceNode.eulerAngles

        let oscClient = F53OSCClient.init()
        oscClient.host = "192.168.86.160"
        oscClient.port = 9001


        let msg = F53OSCMessage(addressPattern: "/head", arguments: [euler.x, 3.14 - euler.z, euler.y])
        oscClient.send(msg)

        for (key, value) in faceAnchor.blendShapes {
            let message = F53OSCMessage(addressPattern: "/" + key.rawValue, arguments: [value])
            oscClient.send(message)
        }
    }
}
