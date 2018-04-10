//
//  FirstViewController.swift
//  krd48_project3
//
//  Created by Drummond,Kyle on 4/6/18.
//  Copyright © 2018 Drummond,Kyle. All rights reserved.
//

import UIKit
import CloudKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view, typically from a nib.
        let publicDB = CKContainer.default().publicCloudDatabase
        
        // setup new mood record
        let firstName = CKRecord(recordType: "firstName")
        firstName["Color"] = 0 as CKRecordValue
        
        // save the record in a public database
        publicDB.save(firstName) {
            record, error in
            
            // NOTE: Should check error, might have a workaround
            if let error = error {
                print(error)
                return
            }
            
            guard let savedRecord = record else {
                print("Error: Unable to save record")
                return
            }
            
            print(savedRecord)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

