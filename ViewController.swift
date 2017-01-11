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
    
    // TODO: ASK CODY IF I SHOULD ACCESS THE API/JSON SERVICE AS A SINGLETON? - OR OTHER WAY? CLEANEST?
  
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
                print("Website JSON Data: \(websiteJSONData["current_observation"])")
                
                for article in websiteJSONData["current_observation"].arrayValue
                {
                    let weather = article["observation_location"]["weather"].stringValue
                  
                    let obj = ["weather": weather]
                    
                    //print("obj in myJSON are  \(objects)")
                    //change newstables variable from here? PUT FOR LOOP IN INIT METHOD OF THIS CLASS?
                    print(obj)
                    
                    self.objects.append(obj)
                    print(objects)
                }
              
                //print(websiteJSONData["weather"])
            }
        }
        
       // weatherLabel.text = objects["weather"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

