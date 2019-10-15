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
        sun.position = SCNVector3(0, 0, -2)
        
        let mercuryParent = SCNNode()
        let earthParent = SCNNode()
        let venusParent = SCNNode()
        let moonParent = SCNNode()
        let marsParent = SCNNode()
        let jupiterParent = SCNNode()
        let saturnParent = SCNNode()
        let uranusParent = SCNNode()
        let neptunParent = SCNNode()
        
        mercuryParent.position = SCNVector3(0,0,-2)
        venusParent.position = SCNVector3(0, 0, -2)
        earthParent.position = SCNVector3(0, 0, -2)
        moonParent.position = SCNVector3(1.2, 0, 0)
        marsParent.position = SCNVector3(0,0,-2)
        jupiterParent.position = SCNVector3(0,0,-2)
        saturnParent.position = SCNVector3(0,0,-2)
        uranusParent.position = SCNVector3(0,0,-2)
        neptunParent.position = SCNVector3(0,0,-2)
        
        // PLANETS
        let mercury = planet(geometry: SCNSphere(radius: 0.05), diffuse: UIImage(named: "mercuryDiffuse")!, specular: nil, emission: nil, normal: nil, position: SCNVector3(0.1, 0, 0))
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: UIImage(named: "venusDiffuse")!, specular: nil, emission: UIImage(named: "venusEmission")!, normal: nil, position: SCNVector3(0.5, 0, 0))
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: UIImage(named: "earthDiffuse")!, specular: UIImage(named: "earthSpecular")!, emission: UIImage(named: "earthEmission")!, normal: UIImage(named: "earthNormal")!, position: SCNVector3(1,0,0))
        let earthMoon = planet(geometry: SCNSphere(radius: 0.05), diffuse: UIImage(named: "moon")!, specular: nil, emission: nil, normal: nil, position: SCNVector3Make(0, 0, 0.3))
        let mars = planet(geometry: SCNSphere(radius: 0.05), diffuse: UIImage(named: "marsDiffuse")!, specular: nil, emission: nil, normal: nil, position: SCNVector3(1.5,0,0))
        let jupiter = planet(geometry: SCNSphere(radius: 0.25), diffuse: UIImage(named: "jupiterDiffuse")!, specular: nil, emission: nil, normal: nil, position: SCNVector3(-2, 0, 0))
        let saturn = planet(geometry: SCNSphere(radius: 0.2), diffuse: UIImage(named: "saturnDiffuse")!, specular: nil, emission: nil, normal: nil, position: SCNVector3(2.2, 0, 0))
        let uranus = planet(geometry: SCNSphere(radius: 0.15), diffuse: UIImage(named: "uranusDiffuse")!, specular: nil, emission: nil, normal: nil, position: SCNVector3(-1, 0, 0))
        let neptun = planet(geometry: SCNSphere(radius: 0.15), diffuse: UIImage(named: "neptuneDiffuse")!, specular: nil, emission: nil, normal: nil, position: SCNVector3(3,0,0))
        
        //TODO: Saturn ring with scntube
        
        let sunRotation = rotation(time: 8)
               sun.runAction(sunRotation)
        
        //PLANETS ROTATIONS AROUND SUN
        let mercuryParentRotation = rotation(time: 4)
        mercuryParent.runAction(mercuryParentRotation)
        let venusParentRotation = rotation(time: 7)
        venusParent.runAction(venusParentRotation)
        let earthParentRotation = rotation(time: 9)
        earthParent.runAction(earthParentRotation)
        let marsParentRotation = rotation(time: 11)
        marsParent.runAction(marsParentRotation)
        let jupiterParentRotation = rotation(time: 13)
        jupiterParent.runAction(jupiterParentRotation)
        let saturnParentRotation = rotation(time: 15)
        saturnParent.runAction(saturnParentRotation)
        let uranusParentRotation = rotation(time: 17)
        uranusParent.runAction(uranusParentRotation)
        let neptunParentRotation = rotation(time: 19)
        neptunParent.runAction(neptunParentRotation)
        
        
        // PLANETS ROTATION AROUND THEMSELVES
        let mercuryRotation = rotation(time: 14)
        mercury.runAction(mercuryRotation)
        let venusRotation = rotation(time: 16)
        venus.runAction(venusRotation)
        let earthRotation = rotation(time: 10)
        earth.runAction(earthRotation)
        let moonRotation = rotation(time: 4)
        moonParent.runAction(moonRotation)
        let marsRotation = rotation(time: 10)
        mars.runAction(marsRotation)
        let jupiterRotation = rotation(time: 7)
        jupiter.runAction(jupiterRotation)
        let saturnRotation = rotation(time: 7)
        saturn.runAction(saturnRotation)
        let uranusRotation = rotation(time: 8.5)
        uranus.runAction(uranusRotation)
        let neptuneRotation = rotation(time: 8)
        neptun.runAction(neptuneRotation)
        
        
        // CHILD-PARENT RELATIONS FOR PLANETS
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(mercuryParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(marsParent)
        self.sceneView.scene.rootNode.addChildNode(jupiterParent)
        self.sceneView.scene.rootNode.addChildNode(saturnParent)
        self.sceneView.scene.rootNode.addChildNode(uranusParent)
        self.sceneView.scene.rootNode.addChildNode(neptunParent)
        
        mercuryParent.addChildNode(mercury)
        venusParent.addChildNode(venus)
        earthParent.addChildNode(earth)
        earthParent.addChildNode(moonParent)
        earth.addChildNode(earthMoon)
        moonParent.addChildNode(earthMoon)
        marsParent.addChildNode(mars)
        jupiterParent.addChildNode(jupiter)
        saturnParent.addChildNode(saturn)
        uranusParent.addChildNode(uranus)
        neptunParent.addChildNode(neptun)
        
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

