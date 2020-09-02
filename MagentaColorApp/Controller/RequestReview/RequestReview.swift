//
//  RequestReview.swift
//  MagentaColorApp
//
//  Created by Stephanie on 9/1/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit
import StoreKit


class RequestReview: UIViewController {

    let runIncrementerSetting = "NumberOfRuns"
    
    //Minimum number of times that the app is run before asking for rating and review
    let minimumRunCount = 3

     func incrementAppRuns() {
         let usD = UserDefaults()
         let runs = getRunCounts() + 1
         usD.setValuesForKeys([runIncrementerSetting: runs])
         usD.synchronize()
     }
    
     func getRunCounts () -> Int {
         let usD = UserDefaults()
         let savedRuns = usD.value(forKey: runIncrementerSetting)
         
         var runs = 0
         if (savedRuns != nil) {
             runs = savedRuns as! Int
         }
         
         print("Run Counts are \(runs)")
         return runs
         
     }
     
     func showReview() {
         let runs = getRunCounts()
         
         if runs % minimumRunCount == 0 {
            print("Review Requested")
            SKStoreReviewController.requestReview()
         } else {
             print("Runs are not enough to request review!")
         }
         
     }
}



