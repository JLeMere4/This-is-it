//
//  MapViewController.swift
//  This is it
//
//  Created by Jack on 11/16/22.
//

/*import CoreLocation
import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet private var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        mapView.centerToLocation(initialLocation)
        let oahuCenter = CLLocation(latitude: 21.4765, longitude: -157.9647)
        let region = MKCoordinateRegion(
          center: oahuCenter.coordinate,
          latitudinalMeters: 50000,
          longitudinalMeters: 60000)
        mapView.setCameraBoundary(
          MKMapView.CameraBoundary(coordinateRegion: region),
          animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        mapView.setCameraZoomRange(zoomRange, animated: true)


        // Do any additional setup after loading the view.
        
        //view.backgroundColor = .green
    }
    
    
    
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
*/

/*import UIKit
import MapKit





class ViewController: UIViewController{
    convenience init(width: Double, height: Double){
        let width: Double = 100.0
        let height: Double = 100.0
        var centerCoordinate: CLLocationCoordinate2D
        var heading: CLLocationDirection
        var centerCoordinateDistance: CLLocationDistance
        var pitch: CGFloat
        self.init()
    }

}


class MapViewController: UIViewController, MKMapViewDelegate {
    
    

    
    struct MKMapSize {


    }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
        }
    }

class MKMapCamera : NSObject{
    
    init(lookingAtCenter: CLLocationCoordinate2D, fromEyeCoordinate: CLLocationCoordinate2D, eyeAltitude: CLLocationDistance){
        

        
    }
    
    
}*/





