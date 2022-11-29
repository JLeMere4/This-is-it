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
    
    
    //fileprivate let locationManager: CLLocationManager = CLLocationManager()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

            
            //setting up users location
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.startUpdatingLocation()
            
            mapView.showsUserLocation = true
        

        

        var currentLoc: CLLocation!
        let manager = CLLocationManager()
        
            locationManager.requestWhenInUseAuthorization()
                  if(manager.authorizationStatus == .authorizedWhenInUse ||
                     manager.authorizationStatus == .authorizedAlways) {
                     currentLoc = locationManager.location
                     print(currentLoc.coordinate.latitude)
                     print(currentLoc.coordinate.longitude)
                  }
            
            
            //messing around with camera
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
            
            
            //creating the circle

        
        
        
        /*class MKCircle : MKShape{
            func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
                return MKOverlayRenderer
            }
        }*/
        
        /*func showCircle(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance, mapView: MKMapView) {
                let circle = MKCircle(center: coordinate, radius: radius)
                mapView.addOverlay(circle)
            }
        
        showCircle(coordinate: currentLoc.coordinate, radius: 1000, mapView: mapView)
        
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
            let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(currentLoc.coordinate.latitude, currentLoc.coordinate.longitude)
            
            mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = location
            annotation.title = "Random Area"
            
            mapView.addAnnotation(annotation)
            */
            
            
        }
        
    }
    

class Map: UIViewController {
    let locationManager = CLLocationManager()
    
    var currentLoc: CLLocation!
    var mapView = MKMapView()
    var radius = 1000.0
    var coordinate =
    
    func setup() {
        mapView.delegate = self
        showCircle(coordinate: coordinate, radius: radius)
    }

    func showCircle(coordinate: CLLocationCoordinate2D,
                    radius: CLLocationDistance) {
        let circle = MKCircle(center: coordinate,
                              radius: radius)
        mapView.addOverlay(circle)
    }
}

extension Map: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView,
                 rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circleOverlay = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: circleOverlay)
            circleRenderer.fillColor = .black
            circleRenderer.alpha = 0.1

            return circleRenderer
        }
    }
}
