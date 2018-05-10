//
//  FirstViewController.swift
//  krd48_project3
//
//  Created by Drummond,Kyle on 4/6/18.
//  Copyright © 2018 Drummond,Kyle. All rights reserved.
//

import UIKit
import CloudKit

class FirstViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var FirstName: UITextField!
    
    @IBOutlet weak var Switch: UISwitch!
    
    @IBOutlet weak var Restaurant: UITextField!
    
    @IBOutlet weak var FavFood: UITextField!
    @IBOutlet weak var LastName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // write value to the App Group User Defaults
        

     
        self.FirstName.delegate = self
        self.LastName.delegate = self
        self.FavFood.delegate = self

        self.Restaurant.delegate = self
        //self.FirstName.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        let publicDB = CKContainer.default().publicCloudDatabase
        
        // setup new mood record
        let firstName = CKRecord(recordType: "z")
        firstName["Color"] = "kyle" as CKRecordValue
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.FirstName.resignFirstResponder()
        self.LastName.resignFirstResponder()
        self.Restaurant.resignFirstResponder()
        self.FavFood.resignFirstResponder()
    
    DispatchQueue.main.async { //performs all writing to plist actions
            if let firstname = self.FirstName.text{
               let lastname = self.LastName.text
               let favfood = self.FavFood.text
               let swic = self.Switch.isOn
                let restaurant = self.Restaurant.text
                
                guard let defaults = UserDefaults(suiteName: "group.edu.uakron.cs.ios.krd48") else {
                    return
                }
                let unique = self.FirstName.text
                print(#function, #line, "Message: ", unique)
                defaults.set(unique, forKey: "Non")
                let unique1 = self.LastName.text
                print(#function, #line, "Message: ", unique1)
                defaults.set(unique1, forKey: "Non2")
                
                
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
                let userNameRecord = CKRecord(recordType: "UserInfo") // //creates the record
                userNameRecord["Name"] = "kyle" as CKRecordValue // c
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
                    
                    // cloudkit stored defaults
                    let keyStore = NSUbiquitousKeyValueStore()
                    
                    // read current count (default is 0 if it does not exist)
                    var first = keyStore.string(forKey: "first")
                    var last = keyStore.string(forKey: "last")
                    var rest = keyStore.string(forKey: "rest")
                    var food = keyStore.string(forKey: "food")

                    
                    first = self.FirstName.text
                    last = self.LastName.text
                    rest = self.Restaurant.text
                    food = self.FavFood.text                    
                    // save current count
                    keyStore.set(first, forKey: "first")
                    keyStore.set(last, forKey: "last")
                    keyStore.set(rest, forKey: "rest")
                    keyStore.set(food, forKey: "food")
                    

                    keyStore.synchronize()

                    
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
                        fetchedRecord["Name"] = firstname as CKRecordValue
                        publicDB.save(fetchedRecord) {
                            record, error in
                            if let error = error {
                                print(error)
                                return
                            }
                            fetchedRecord["Last"] = lastname! as CKRecordValue
                            publicDB.save(fetchedRecord) {
                                record, error in
                                if let error = error {
                                    print(error)
                                    return
                                }
                            }
                              
                            fetchedRecord["food"] = favfood! as CKRecordValue
                            publicDB.save(fetchedRecord) {
                                record, error in
                                if let error = error {
                                    print(error)
                                    return
                                }
                            }
                            
                            
                            fetchedRecord["rest"] = restaurant! as CKRecordValue
                            publicDB.save(fetchedRecord) {
                                record, error in
                                if let error = error {
                                    print(error)
                                    return
                                }
                            }
                          
                            fetchedRecord["switch"] = swic as CKRecordValue
                            publicDB.save(fetchedRecord) {
                                record, error in
                                if let error = error {
                                    print(error)
                                    return
                                }
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
    
    




