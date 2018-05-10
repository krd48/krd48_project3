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
        guard let message = UserDefaults(suiteName: "group.edu.uakron.cs.ios.krd48")?.string(forKey: "Non") else {
            print("Error: Unable to access App Group")
            completionHandler(NCUpdateResult.noData)
            return
        }
        
        guard let message2 = UserDefaults(suiteName: "group.edu.uakron.cs.ios.krd48")?.string(forKey: "Non2") else {
            print("Error: Unable to access App Group")
            completionHandler(NCUpdateResult.noData)
            return
        }
        self.last.text = message2
        self.firstname.text = message
        
        print(#function, #line, "Message: ", message)
        
     
        completionHandler(NCUpdateResult.noData)
        
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
    

