//
//  SecondViewController.swift
//  krd48_project3
//
//  Created by Drummond,Kyle on 4/6/18.
//  Copyright © 2018 Drummond,Kyle. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    lazy var location = CLLocationManager()
    
    lazy var ua:MKPointAnnotation = {
        
        var ann = MKPointAnnotation()
        ann.coordinate = CLLocationCoordinate2DMake(41.0778312683105, -81.510684290037237)
        ann.title = "University of Akron"
        ann.subtitle = "College of Arts and Sciences"
        
        return ann
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        // Note: consider changing to only what is needed
        location.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        // request to use the location when in the foreground
        location.requestWhenInUseAuthorization()
        
        self.mapView.showsUserLocation = true
        
        // satellite and road name info
        self.mapView.mapType = .hybrid
        
        // region around UA
        let UALocation = CLLocationCoordinate2DMake(41.0778312683105, -81.510684290037237)
        let mapRegion = MKCoordinateRegion(center: UALocation, span: MKCoordinateSpanMake(0.001, 0.001))
        
        // zoom the map to the location
        self.mapView.setRegion(mapRegion, animated: true)
        
        // add an annotation for UA
        self.mapView.addAnnotation(ua)
        
        // now ready for the location updates
        location.startUpdatingLocation()
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        // region around user location
        let mapRegion = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpanMake(0.001, 0.001))
        
        // zoom the map to the user location
        mapView.setRegion(mapRegion, animated: true)
    }
    
    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
        print(#function)
        print(error)
    }
    
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
        print(#function)
        print(error)
    }
    
    
}
