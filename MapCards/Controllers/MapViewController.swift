//
//  MapViewController.swift
//  MapCards
//
//  Created by Eugène Peschard on 09/05/2017.
//  Copyright © 2017 PeschApps. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  let locationManager = CLLocationManager()
  
  // MARK: Initialization
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    commonInit()
  }
  
  fileprivate func commonInit() {
    locationManager.delegate = self
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    mapView.delegate = self
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    locationManager.requestWhenInUseAuthorization()
    mapView.showsUserLocation = true
//    updateLocations()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    self.mapView.showsUserLocation = false
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

extension MapViewController: CLLocationManagerDelegate {
  /*
  func updateLocations() {
    mapView.removeAnnotations(mapView.annotations)
    
    for location in locations {
      mapView.addAnnotation(location)
    }
    mapView.showAnnotations(Array(locations), animated: true)
    //    zoomToAllAnnotations()
  }*/
  
  func showLocationDetails(_ sender: UIButton) {
    performSegue(withIdentifier: "EditLocation", sender: sender)
  }
  
//  func zoomToAllAnnotations() {
//    let annotationPoint = MKMapPointForCoordinate(mapView.userLocation.coordinate)
//    var zoomRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1)
//    for annotation in mapView.annotations {
//      let annotationPoint = MKMapPointForCoordinate(annotation.coordinate)
//      let pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1)
//      zoomRect = MKMapRectUnion(zoomRect, pointRect)
//    }
//    mapView.setVisibleMapRect(zoomRect, animated: true)
//  }
  
}

extension MapViewController: MKMapViewDelegate {
  
  func mapView(_ mapView: MKMapView,
               viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
//    guard annotation is Location else {
//      return nil
//    }
    
    // Leave default annotation for user location
    if annotation is MKUserLocation {
      return nil
    }
    
    let reuseID = "Location"
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
    if annotationView == nil {
      let pin = MKAnnotationView(annotation: annotation,
                                 reuseIdentifier: reuseID)
      pin.image = UIImage(named: "redPin")
      pin.isEnabled = true
      pin.canShowCallout = true
      
      let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
      label.backgroundColor = .blue
      label.alpha = 0.8
      label.textColor = .white
      label.layer.cornerRadius = 15
      label.clipsToBounds = true
      label.text = "1"
      
      pin.addSubview(label)
      
//          pin.frame = label.frame

//          pin.animatesDrop = false
//          pin.pinTintColor = UIColor(red: 0.32, green: 0.82,
//                                         blue: 0.4, alpha: 1)
//          pin.tintColor = UIColor(white: 0.0, alpha: 0.5)


//      let leftButtonImage = UIImage(named: "add32")!
//      let leftButton = UIButton(type: .Custom)
//      leftButton.frame = CGRectMake(10.0, 10.0, 32.0, 32.0)
//      leftButton.tag = 0
//      leftButton.setImage(leftButtonImage,
//                          forState: UIControlState.Normal)

//      let rightButton = UIButton(type: .detailDisclosure)
//          rightButton.addTarget(self,
//                                action: #selector(showLocationDetails),
//                                for: .touchUpInside)
//      pin.rightCalloutAccessoryView = rightButton
      
      annotationView = pin
    } else {
      annotationView?.annotation = annotation
    }
    
//    if let annotationView = annotationView {
//      annotationView.annotation = annotation
//
//      let button = annotationView.rightCalloutAccessoryView as! UIButton
//      if let index = locations.index(of: annotation as! Entity) {
//        button.tag = index
//      }
//    }

//    let label = annotationView?.viewWithTag(19) as! UILabel
//        label.text = annotation.title!
    
    return annotationView
  }
}
