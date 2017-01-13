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

    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    // TODO: ASK CODY IF I SHOULD ACCESS THE API/JSON SERVICE AS A SINGLETON? - OR OTHER WAY? CLEANEST?
  
    // dont need 2d array because for dailyread, each article had unique title, text etc, but here I can just do one temp, one condition, one logo etc. 
    var objects: [[String: String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myUrlStringInput: String = "http://api.wunderground.com/api/4f16fc1990d1c023/forecast/geolookup/conditions/q/CA/San_Francisco.json"
        //print("myJSON inputURL: \(myUrlStringInput)")
        
        if let nsurlStringInput = URL(string: myUrlStringInput)
        { // We have to convert to NSURL because contentsOfUrl takes NSURL as a paramater.
            //print("NSURL string input: \(nsurlStringInput)")
            
            if let websiteNSData = try? Data(contentsOf: nsurlStringInput, options: [])
            { // We have to convert it to NSData because swiftyJSON's type JSON uses NSData as a paramter.
                //print("Website's NSDATA: \(websiteNSData)")
                
                let websiteJSONData = JSON(data: websiteNSData)
                //print("Website JSON Data: \(websiteJSONData["current_observation"].dictionaryValue)")
                
                let weather = websiteJSONData["current_observation"]["weather"].stringValue
                let temp = websiteJSONData["current_observation"]["temp_f"].stringValue

                let obj = ["weather": weather, "temp": temp]
                

                    self.objects.append(obj)
                    print("objects: \(objects)")
//                }
              
                //print(websiteJSONData["weather"])
            }
        }
        
        weatherLabel.text = objects[0]["weather"]
        tempLabel.text = objects[0]["weather"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

