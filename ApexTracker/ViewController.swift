//
//  ViewController.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 14.04.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    


    
        
    var networkManager: TrackerGGNetworkManager = TrackerGGNetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        networkManager.getProfileStats(platform: .origin, userId: "harry17061") { (data, error) in
            
            if let error = error {
                print(error)
            } else {
                print(data!)
            }
    
        }
    }
    
    


}
