//
//  FaceViewController.swift
//  EyeTrackingTest
//
//  Created by Jason Shang on 10/29/21.
//

import ARKit
import SwiftUI
import SceneKit
import UIKit
import Foundation

// MARK: - sceneViewIndicator
// used for wrapping UIKit UIViewController type (sceneView class below) into SwiftUI

struct sceneViewIndicator: UIViewControllerRepresentable {
   typealias UIViewControllerType = sceneView
   
   func makeUIViewController(context: Context) -> sceneView {
      return sceneView()
   }
    
   func updateUIViewController(_ uiViewController:
   sceneViewIndicator.UIViewControllerType, context:
   UIViewControllerRepresentableContext<sceneViewIndicator>) {}
}

// MARK: sceneView
class sceneView: UIViewController, ARSCNViewDelegate {
    
    var sceneView: ARSCNView {
        return self.view as! ARSCNView
    }
    
    override func loadView() {
        self.view = ARSCNView(frame: .zero)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.scene = SCNScene()
        
        sceneView.automaticallyUpdatesLighting = true
    }

    // MARK: - Functions for standard AR view handling
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // AR experiences typically involve moving the device without
        // touch input for some time, so prevent auto screen dimming.
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      let configuration = ARWorldTrackingConfiguration()
      sceneView.session.run(configuration)
      sceneView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    func sessionWasInterrupted(_ session: ARSession) {}

    func sessionInterruptionEnded(_ session: ARSession) {}
    
    func session(_ session: ARSession, didFailWithError error: Error)
    {}
    
    func session(_ session: ARSession, cameraDidChangeTrackingState
    camera: ARCamera) {}
}
