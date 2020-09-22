//
//  MapVC.swift
//  AlarTest
//
//  Created by Oleg Frolov on 22.09.2020.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var coordinate = CLLocationCoordinate2D()
    var place: Place!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = place.name
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = coordinate
        annotation.title = "\(place.country)\n\(place.name)\n\(place.id)"
        annotation.subtitle =  "\(place.lat) \(place.lon)"
        
        mapView.addAnnotation(annotation)
        mapView.camera.centerCoordinate = coordinate
        mapView.camera.centerCoordinateDistance = 20000
    }
    
}
