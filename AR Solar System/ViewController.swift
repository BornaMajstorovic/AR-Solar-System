//
//  ViewController.swift
//  AR Solar System
//
//  Created by Borna on 09/10/2019.
//  Copyright © 2019 Borna. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var sceneView: ARSCNView!
    
    // MARK: Properties
    let configuration = ARWorldTrackingConfiguration()
   
    
    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.sceneView.debugOptions = [.showWorldOrigin, .showFeaturePoints]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        simulation()
     
    }

    // MARK: Actions
    
    // MARK: CLass methods
    
    func simulation() {
        
            let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "sun")
            sun.position = SCNVector3(0, 0, -1)
            
                
            let earthParent = SCNNode()
            let venusParent = SCNNode()
            let moonParent = SCNNode()
        
            earthParent.position = SCNVector3(0, 0, -1)
            venusParent.position = SCNVector3(0, 0, -1)
            moonParent.position = SCNVector3(1.2, 0, 0)
         
                            
            let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: UIImage(named: "earthDiffuse")!, specular: UIImage(named: "earthSpecular")!, emission: UIImage(named: "earthEmission")!, normal: UIImage(named: "earthNormal")!, position: SCNVector3(1.25,0,0))
            let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: UIImage(named: "venusDiffuse")!, specular: nil, emission: UIImage(named: "venusEmission")!, normal: nil, position: SCNVector3(0.7, 0, 0))
            let earthMoon = planet(geometry: SCNSphere(radius: 0.05), diffuse: UIImage(named: "moon")!, specular: nil, emission: nil, normal: nil, position: SCNVector3Make(0, 0, 0.3))
            
            
            let sunRotation = rotation(time: 8)
            let earthParentRotation = rotation(time: 14)
            let venusParentRotation = rotation(time: 10)
            let earthRotation = rotation(time: 8)
            let moonRotation = rotation(time: 5)
            let venusRotation = rotation(time: 8)
            
            
            earth.runAction(earthRotation)
            venus.runAction(venusRotation)
            earthParent.runAction(earthParentRotation)
            venusParent.runAction(venusParentRotation)
            moonParent.runAction(moonRotation)
            sun.runAction(sunRotation)
            
            
                
            self.sceneView.scene.rootNode.addChildNode(sun)
            self.sceneView.scene.rootNode.addChildNode(earthParent)
            self.sceneView.scene.rootNode.addChildNode(venusParent)
        
            earthParent.addChildNode(earth)
            earthParent.addChildNode(moonParent) 
            earth.addChildNode(earthMoon)
            moonParent.addChildNode(earthMoon)
            venusParent.addChildNode(venus)
                
        
    }

    func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        
        planet.position = position
        return planet
    }

    func rotation(time: TimeInterval) -> SCNAction {
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360 * Double.pi / 180), z: 0, duration: time)
        let forever = SCNAction.repeatForever(action)
        
        return forever
    }

}

