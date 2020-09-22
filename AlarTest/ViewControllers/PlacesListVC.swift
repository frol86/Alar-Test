//
//  PlacesListVC.swift
//  AlarTest
//
//  Created by Oleg Frolov on 21.09.2020.
//

import UIKit
import MapKit

class PlacesListVC: UITableViewController  {
    
    var placesManager = PlacesManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Airports"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        placesManager.placesArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        cell.textLabel?.text = placesManager.placesArray![indexPath.row].name
        
        if cell.imageView?.image == nil {
            cell.imageView?.generateImage()
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let record = placesManager.placesArray![indexPath.row]
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Map") as! MapVC
        vc.modalPresentationStyle = .fullScreen
        vc.coordinate = CLLocationCoordinate2D(latitude: record.lat, longitude: record.lon)
        vc.place = record
        show(vc, sender: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if placesManager.placesArray!.count-2 == indexPath.row {
            let page = (placesManager.placesArray!.count / 10) + 1
            self.placesManager.getPlaces(code: AppSettings.shared.authCode, page: page) { places in
                if let places = places {
                    self.placesManager.placesArray! += places.data
                    tableView.reloadData()
                }
            }
        }
    }
    
}

