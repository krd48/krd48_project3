//
//  SecondViewController.swift
//  krd48_project3
//
//  Created by Drummond,Kyle on 4/6/18.
//  Copyright © 2018 Drummond,Kyle. All rights reserved.
//

import UIKit
import MapKit
import CloudKit

class SecondViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var Location: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    lazy var location = CLLocationManager()
    
    lazy var ua:MKPointAnnotation = {
        
        var ann = MKPointAnnotation()
        ann.coordinate = CLLocationCoordinate2DMake(41.496577, -81.688076)
        ann.title = "Cleveland"
        ann.subtitle = "Quicken Loans Arena"
        
        return ann
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Location.delegate = self

        self.mapView.delegate = self
        
        // Note: consider changing to only what is needed
        location.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        // request to use the location when in the foreground
        location.requestWhenInUseAuthorization()
        
        self.mapView.showsUserLocation = true
        
        // satellite and road name info
        self.mapView.mapType = .hybrid
        
        // region around UA
        let UALocation = CLLocationCoordinate2DMake(41.496577, -81.688076)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.Location.resignFirstResponder()
       DispatchQueue.main.async { //performs all writing to plist actions
            if let location = self.Location.text{
                
                CKContainer.default().fetchUserRecordID() {
                    recordID, error in
                    
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    guard let userID = recordID?.recordName else {
                        print("Error: Unable to get unique user ID")
                        return
                    }
                    
                    print("User ID: \(userID)")
                }
                
                let publicDB = CKContainer.default().publicCloudDatabase
                let userNameRecord = CKRecord(recordType: "status") // //creates the record
                userNameRecord["location"] = location as CKRecordValue // c
                print("record name: \(userNameRecord)")
                
                publicDB.save(userNameRecord) {
                    record, error in
                    if let error = error {
                        print(error)
                        return
                    }
                    guard let savedRecord = record else {
                        print("Error: Unable to access record from save")
                        return
                    }
                    print("Saved Record: \(savedRecord) RecordID: \(savedRecord.recordID)")
                    
                    
                    
                    publicDB.fetch(withRecordID: savedRecord.recordID) {
                        record, error in
                        if let error = error {
                            print(error)
                            return
                        }
                        guard let fetchedRecord = record else {
                            return
                        }
                        print("Fetched Record: \(fetchedRecord) RecordID: \(fetchedRecord.recordID)")
                        fetchedRecord["location"] = location as CKRecordValue
                        publicDB.save(fetchedRecord) {
                            record, error in
                            if let error = error {
                                print(error)
                                return
                            }
                   
                            
                            guard let updatedRecord = record else {
                                print("Error: Unable to update record")
                                return
                            }
                            print("Updated Record: \(updatedRecord) RecordID: \(updatedRecord.recordID)")
                        }
                    }
                }
            }
        }
        return true
    }
    
    
}
