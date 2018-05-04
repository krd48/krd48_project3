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
    
  
    
    @IBAction func linkTodayExtension(_ sender: Any) {
        
        let path = URL(string: "linkButtonTodayExtension://")!
        extensionContext?.open(path, completionHandler: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
    }
    
    
  
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
     
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
    

