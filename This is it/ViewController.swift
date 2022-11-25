//
//  ViewController.swift
//  This is it
//
//  Created by Jack on 11/14/22.
//
//https://developer.apple.com/documentation/mapkit/enabling_maps_capability_in_xcode



import UIKit
import MapKit
import CoreLocation
import FloatingPanel

class ViewController: UIViewController, FloatingPanelControllerDelegate {
    
    
    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting up map
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        
        let oahuCenter = CLLocation(latitude: 33.69, longitude: -112.3100)
        let region = MKCoordinateRegion(
          center: oahuCenter.coordinate,
          latitudinalMeters: 10000000,
          longitudinalMeters: 10000000)
        mapView.setCameraBoundary(
          MKMapView.CameraBoundary(coordinateRegion: region),
          animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 100000000)
        mapView.setCameraZoomRange(zoomRange, animated: true)

        //creating the floating panel
        let fpc = FloatingPanelController()
        fpc.delegate = self
        
        guard let contentVC = storyboard?.instantiateViewController(identifier: "fpc_content") as? ContentViewController else {
            return
        }
        
        fpc.set(contentViewController: contentVC)
        
        fpc.addPanel(toParent: self)
    }
    
}


