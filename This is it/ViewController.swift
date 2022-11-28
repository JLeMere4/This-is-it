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
        
        var  latitude = 1.1
        var  longitude = 1.1
        var currentLoc: CLLocation!
        var c = 1
        while(c<=3){
            latitude = currentLoc.coordinate.latitude
            longitude = currentLoc.coordinate.longitude
        
        let manager = CLLocationManager()
        if(manager.authorizationStatus == .authorizedWhenInUse ||
           manager.authorizationStatus == .authorizedAlways) {
            currentLoc = locationManager.location
            c=c+1
        }
            print(latitude)
            print(longitude)
        
            
            
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
            
            
            
            let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
            let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(currentLoc.coordinate.latitude, currentLoc.coordinate.longitude)
            
            mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = location
            annotation.title = "Random Area"
            
            mapView.addAnnotation(annotation)
            
            
            
        }
        
    }
    
}
