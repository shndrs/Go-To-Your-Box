//
//  ViewController.swift
//  Go To Your Box
//
//  Created by Sahand Raeisi on 1/19/19.
//  Copyright © 2019 Sahand Raeisi. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    
    
    
    func setUpScene() {
        let node = SCNNode()
        
        let leftWall = createBox(isDoor: false)
        leftWall.position = SCNVector3(-length/2, 0, 0)
        
        let rightWall = createBox(isDoor: false)
        rightWall.position = SCNVector3(length/2, 0, 0)
        
        let topWall = createBox(isDoor: false)
        topWall.position = SCNVector3(0, height/2, 0)
        
        let bottomWall = createBox(isDoor: false)
        bottomWall.position = SCNVector3(0, -height/2, 0)
        
        let backWall = createBox(isDoor: false)
        backWall.position = SCNVector3(0, 0, length/2)
        
        let leftDoorSide = createBox(isDoor: true)
        leftDoorSide.position = SCNVector3(-doorLength/2, 0, doorLength/2)
        
        
        let rightDoorSide = createBox(isDoor: true)
        rightDoorSide.position = SCNVector3(doorLength/2, 0, doorLength/2)
        
        node.addChildNode(leftWall)
        node.addChildNode(rightWall)
        node.addChildNode(topWall)
        node.addChildNode(bottomWall)
        node.addChildNode(backWall)
        node.addChildNode(leftDoorSide)
        node.addChildNode(rightDoorSide)
        
        self.sceneView.scene.rootNode.addChildNode(node)
        
    }
    

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
