//
//  ViewController.swift
//  This is it
//
//  Created by Jack on 11/14/22.
//
//https://developer.apple.com/documentation/mapkit/enabling_maps_capability_in_xcode
/*
import UIKit
import MapKit

class iewController: UIViewController {
    @IBOutlet private var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)

        // Do any additional setup after loading the view.
        
        //view.backgroundColor = .green
    }
    private extension MKMapView {
      func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000
      ) {
        let coordinateRegion = MKCoordinateRegion(
          center: location.coordinate,
          latitudinalMeters: regionRadius,
          longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
      }
    }


}

*/


import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    
    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
    }
    
}
