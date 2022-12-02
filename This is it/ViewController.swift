
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
import SwiftUI

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
       // new shit below
       addRadiusCircle(location: currentLoc)
       func addRadiusCircle(location: CLLocation){
              self.mapView.delegate = self
           var circle = MKCircle(center: currentLoc.coordinate, radius: 10000 as CLLocationDistance)
              self.mapView.addOverlay(circle)
          }

          func mapViews(mapViews: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
              if overlay is MKCircle {
                  var circle = MKCircleRenderer(overlay: overlay)
                  circle.strokeColor = UIColor.red
                  circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.1)
                  circle.lineWidth = 1
                  return circle
              } else {
                  return nil
              }
          }
    // new shit above
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
       //Looks for single or multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
 
        view.addGestureRecognizer(tap)
    }
 
    //called when go button pressed
    @objc func dismissKeyboard() {
        view.endEditing(true)

   }
    
   func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
       let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
       render.strokeColor = .blue
       return render
   }
    
}

