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
        sceneView.delegate = self
        sceneView.showsStatistics = true
        setUpScene()
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
        node.position = SCNVector3(0, 0, 0)
        
        let leftWall = createBox(isDoor: false)
        leftWall.position = SCNVector3(-length/2, 0, 0)
        leftWall.eulerAngles = SCNVector3(0, 180.0.degreesToRadian, 0)
        
        let rightWall = createBox(isDoor: false)
        rightWall.position = SCNVector3(length/2, 0, 0)
        
        let topWall = createBox(isDoor: false)
        topWall.position = SCNVector3(0, height/2, 0)
        topWall.eulerAngles = SCNVector3(0, 0, 90.0.degreesToRadian)
        
        let bottomWall = createBox(isDoor: false)
        bottomWall.position = SCNVector3(0, -height/2, 0)
        bottomWall.eulerAngles = SCNVector3(0, 0, -90.0.degreesToRadian)
        
        let backWall = createBox(isDoor: false)
        backWall.position = SCNVector3(0, 0, length/2)
        backWall.eulerAngles = SCNVector3(0, 90.0.degreesToRadian, 0)
        
        let leftDoorSide = createBox(isDoor: true)
        leftDoorSide.position = SCNVector3(-doorLength/2, 0, doorLength/2)
        leftDoorSide.eulerAngles = SCNVector3(0, -90.0.degreesToRadian, 0)
        
        let rightDoorSide = createBox(isDoor: true)
        rightDoorSide.position = SCNVector3(doorLength/2, 0, doorLength/2)
        rightDoorSide.eulerAngles = SCNVector3(0, -90.0.degreesToRadian, 0)
        
        
        let light = SCNLight()
        light.type = .spot
        light.spotInnerAngle = 70
        light.spotOuterAngle = 120
        light.zNear = 0.00001
        light.zFar = 5
        light.castsShadow = true
        light.shadowRadius = 200
        light.shadowColor = UIColor.black.withAlphaComponent(0.3)
        light.shadowMode = .deferred
        let constraint = SCNLookAtConstraint(target: bottomWall)
        constraint.isGimbalLockEnabled = true
        
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3(0, height/2, 0)
        lightNode.constraints = [constraint]
        node.addChildNode(lightNode)
        
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
