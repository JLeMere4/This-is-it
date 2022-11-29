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
 
class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    //fileprivate let locationManager: CLLocationManager = CLLocationManager()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //setting up users location
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        
        
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
        /*
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
        */
        
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
    
    @IBOutlet var getDirectionsButton: UIButton!
    @IBOutlet var textFieldForAddress: UITextField!
    
    @IBAction func getDirectionsTapped(_ sender: Any) {
        getAddress()
    }
    
    func getAddress() {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(textFieldForAddress.text!) { (placemarks, error)
            in
            guard let placemarks = placemarks, let location = placemarks.first?.location
                else {
                    print("No Location Found")
                    return
            }
            print(location)
            self.mapThis(destinationCord: location.coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    func mapThis(destinationCord : CLLocationCoordinate2D) {
        
        let sourceCordinate = (locationManager.location?.coordinate)!
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceCordinate)
        let destPlaceMark = MKPlacemark(coordinate: destinationCord)
        
        let sourceItem = MKMapItem(placemark: sourcePlaceMark)
        let destItem = MKMapItem(placemark: destPlaceMark)
        
        let destinationRequest = MKDirections.Request()
        destinationRequest.source = sourceItem
        destinationRequest.destination = destItem
        destinationRequest.transportType = .automobile
        destinationRequest.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: destinationRequest)
        directions.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("Something is wrong :(")
                }
                return
            }
            
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        return render
    }
    
}
 


