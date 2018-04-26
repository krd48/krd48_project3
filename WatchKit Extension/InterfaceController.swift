//
//  InterfaceController.swift
//  WatchKit Extension
//
//  Created by Drummond,Kyle on 4/25/18.
//  Copyright © 2018 Drummond,Kyle. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var mapview: WKInterfaceMap!
    var location = CLLocationManager()
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        super.willActivate()
        
//        location.delegate = self
//        location.desiredAccuracy = kCLLocationAccuracyBestForNavigation
//        location.startUpdatingLocation()
//        location.requestWhenInUseAuthorization()
//

        let cavscords = CLLocationCoordinate2D(latitude: 41.496577, longitude: -81.688076)
        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        self.mapview.addAnnotation(cavscords, with: .purple)
        self.mapview.setRegion(MKCoordinateRegion(center: cavscords, span: coordinateSpan))
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
