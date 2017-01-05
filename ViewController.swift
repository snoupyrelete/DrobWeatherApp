//
//  ViewController.swift
//  DrobWeatherApp
//
//  Created by Robson, Dylan on 1/5/17.
//  Copyright © 2017 Robson, Dylan. All rights reserved.
//

import UIKit
import SwiftyJSON


class ViewController: UIViewController {

    
    let json = JSON(data: dataFromNetworking)
    let json = JSON(jsonObject)
    if let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false) {
        let json = JSON(data: dataFromString)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

