//
//  LocationSearchController.swift
//  DrobWeatherApp
//
//  Created by Robson, Dylan on 2/24/17.
//  Copyright © 2017 Robson, Dylan. All rights reserved.
//

import Foundation
import UIKit

class LocationSearchController : UITableViewController, UISearchBarDelegate
{
    
    var results : [[String : String]] = []
    @IBOutlet weak var locationSearchBar: UISearchBar!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        locationSearchBar.delegate = self
        
       // results = [["a":"b"]]
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        print("srch btn click")
        
        let searchBarText = locationSearchBar.text
        // TODO: make an API call, but with the autocomplete REST endpoint instead.
        let myUrlStringInput: String = "http://autocomplete.wunderground.com/aq?query=" + searchBarText!
        
        if let nsurlStringInput = URL(string: myUrlStringInput)
        { // We have to convert to NSURL because contentsOfUrl takes NSURL as a paramater.
            
            if let websiteNSData = try? Data(contentsOf: nsurlStringInput, options: [])
            { // We have to convert it to NSData because swiftyJSON's type JSON uses NSData as a paramter.
                
                let websiteJSONData = JSON(data: websiteNSData)
                
                let resultCount = websiteJSONData["RESULTS"].count
                for i in 0..<resultCount
                {
                    let name = websiteJSONData["RESULTS"][i]["name"].stringValue
                    let country = websiteJSONData["RESULTS"][i]["c"].stringValue
                    let zmw = websiteJSONData["RESULTS"][i]["zmw"].stringValue
                    
                    let result = ["name": name, "country" : country, "zmw": zmw]
                    
                    self.results.append(result)

                }
                
                
                
                
                
                self.tableView.reloadData()
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return results.count

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: if there is no image received let cell = another cell class (as! otherCell) so that it loads a view without an image, with title and description scaled accordingly. xib files?
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
    
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
 
        cell.textLabel?.text = results[indexPath.row]["name"]
        cell.detailTextLabel?.text = results[indexPath.row]["name"]
        
        
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "toWeather"
        {
            let city = results[0]["zmw"]! + ".json"
            if let destination = segue.destination as? ViewController
            {
                destination.newLocation = city
            }
        }
        
    }
}
