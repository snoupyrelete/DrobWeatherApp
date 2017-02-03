//
//  ViewController.swift
//  DrobWeatherApp
//
//  Created by Robson, Dylan on 1/5/17.
//  Copyright © 2017 Robson, Dylan. All rights reserved.
//

import UIKit
import SwiftyJSON


class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    // TODO: this is the endpoint for the autocomplete for the search bar : http://autocomplete.wunderground.com/aq?query=query
    // TODO: ASK CODY IF I SHOULD ACCESS THE API/JSON SERVICE AS A SINGLETON? - OR OTHER WAY? CLEANEST?
    // TODO: switch to one of wunderground's iconsets -it's easier. I like set #11, #10, & #9.
    // TODO: UISearchBar delegate methods
    
    // I like the fact that you have a TODO for what you want to accomplish each day.
    // dont need 2d array because for dailyread, each article had unique title, text etc, but here I can just do one temp, one condition, one logo etc. could use 2d array though if storing multiple cities.
    
    // Switch to guards instead of iflets?
    var objects: [[String: String]] = []
    
    @IBOutlet weak var locationSearchBar: UISearchBar!
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar)
    {
        // TODO: make an API call, but with the autocomplete REST endpoint instead.
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let myUrlStringInput: String = "http://api.wunderground.com/api/4f16fc1990d1c023/forecast/geolookup/conditions/q/CA/San_Francisco.json"
  
        if let nsurlStringInput = URL(string: myUrlStringInput)
        { // We have to convert to NSURL because contentsOfUrl takes NSURL as a paramater.
        
            if let websiteNSData = try? Data(contentsOf: nsurlStringInput, options: [])
            { // We have to convert it to NSData because swiftyJSON's type JSON uses NSData as a paramter.
           
                let websiteJSONData = JSON(data: websiteNSData)
              
                let weather = websiteJSONData["current_observation"]["weather"].stringValue
                let temp = websiteJSONData["current_observation"]["temp_f"].stringValue
                let icon = websiteJSONData["current_observation"]["icon"].stringValue
                let location = websiteJSONData["current_observation"]["display_location"]["full"].stringValue

                let obj = ["weather": weather, "temp": temp, "icon": icon, "location": location]
                self.objects.append(obj)
            }
        }
        
        weatherLabel.text = objects[0]["weather"]
        tempLabel.text = objects[0]["temp"]! + "°F"
        locationLabel.text = objects[0]["location"]
        
        // Their assets suck - they all have white backgrounds.
        if let url = NSURL(string: "https://icons.wxug.com/i/c/j/" + objects[0]["icon"]! + ".gif")
        {
            if let data = NSData(contentsOf: url as URL)
            {
                iconImageView.image = UIImage(data: data as Data)
            }
        }
        
    }
}

