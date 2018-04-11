//
//  ThirdViewController.swift
//  krd48_project3
//
//  Created by Drummond,Kyle on 4/11/18.
//  Copyright © 2018 Drummond,Kyle. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    
    
     
    @IBAction func pan(_ sender: UIPanGestureRecognizer) {
    
    
        if sender.state == .began || sender.state == .changed {
            let translation = sender.translation(in: sender.view)
            let changeX = (sender.view?.center.x)! + translation.x
            let changeY = (sender.view?.center.y)! + translation.y
            
            sender.view?.center = CGPoint(x: changeX, y:changeY)
            sender.setTranslation(CGPoint.zero, in: sender.view)
        }
        
    }
    @IBOutlet weak var imgImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgImage.isUserInteractionEnabled = true
        
        // pinch to zoom gesture
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchGesture))
        imgImage.addGestureRecognizer(pinchGesture)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // pinch to zoom gesture
    @objc func pinchGesture(sender:UIPinchGestureRecognizer){
        sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
        sender.scale = 1.0
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

