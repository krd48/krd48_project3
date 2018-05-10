//
//  TodayViewController.swift
//  todayextension
//
//  Created by Drummond,Kyle on 5/1/18.
//  Copyright © 2018 Drummond,Kyle. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
  

    @IBOutlet weak var last: UILabel!
    @IBOutlet weak var firstname: UILabel!
    
    @IBAction func linkTodayExtension(_ sender: Any) {
        
        let path = URL(string: "linkButtonTodayExtension://")!
        extensionContext?.open(path, completionHandler: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
    }
    
    
  
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        // read value from the App Group User Defaults
        /* Note: Will need to adjust to your App Group name */
        guard let message = UserDefaults(suiteName:"group.edu.uakron.cs.ios.krd48")?.string(forKey: "Message") else {
            print("Error: Unable to access App Group")
            completionHandler(NCUpdateResult.noData)
            return
        }
       
        guard let last = UserDefaults(suiteName:"group.edu.uakron.cs.ios.krd48")?.string(forKey: "Message") else {
            print("Error: Unable to access App Group")
            completionHandler(NCUpdateResult.noData)
            return
        }
        print(#function, #line, "Message: ", message)
        self.firstname.text = message
        self.last.text = last
     
        completionHandler(NCUpdateResult.newData)
        
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == NCWidgetDisplayMode.compact
        {
            self.preferredContentSize = maxSize
        }
        else{
            self.preferredContentSize = CGSize(width: maxSize.width, height: 150)
        }
    }
    
  
    
}
    

