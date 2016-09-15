//
//  ViewController.swift
//  MapAssignment
//
//  Created by ycliang on 2016/9/14.
//  Copyright © 2016年 Alex Liang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var isFirstLocation = false
    var geoCoder = CLGeocoder()
    var userAddress = ""
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager.requestWhenInUseAuthorization()
        
        
        let firstAnnotation = FriendAnnotation(coordinate: CLLocationCoordinate2D(latitude: 25.078489, longitude: 121.575207), title: "Alex", subtitle: "Friend1", address: "台北市內湖區洲子街12號")
        self.mapView.addAnnotation(firstAnnotation)
        
        let secondAnnotation = FriendAnnotation(coordinate: CLLocationCoordinate2D(latitude: 25.067138, longitude: 121.660261), title: "John", subtitle: "Friend2", address: "新北市汐止區汐科路321號")
        self.mapView.addAnnotation(secondAnnotation)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        if self.isFirstLocation == false {
            self.isFirstLocation = true
            
            let region = MKCoordinateRegion(center: userLocation.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            mapView.setRegion(region, animated: true)
            
            self.geoCoder.reverseGeocodeLocation(userLocation.location!) {
                (places:[CLPlacemark]?, err: NSError?) -> Void in
                
                if places?.count > 0 {
                    let placeMark = places?.first
                    let addressArray = placeMark?.addressDictionary?["FormattedAddressLines"] as! [String]
                    for address in addressArray {
                        self.userAddress = address
                        print("\(address)")
                    }
                }
            }
            
            mapView.region = region
            mapView.setCenterCoordinate(userLocation.coordinate, animated: true)
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: MKAnnotationView? = nil
        
        if annotation is FriendAnnotation {
            annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("Pin")
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
                annotationView?.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
                annotationView?.canShowCallout = true
            }
            
            let pinAnnoView = annotationView as! MKPinAnnotationView
            let friendAnno = annotation as! FriendAnnotation
            if friendAnno.subtitle == "Friend1" {
                pinAnnoView.pinTintColor = UIColor.blueColor()
            } else {
                pinAnnoView.pinTintColor = UIColor.brownColor()
            }
        }
        
        return annotationView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annotation = view.annotation
        if let title = annotation?.title {
            if title == "Alex" {
                print("Alex's home")
            } else {
                print("John's home")
            }
        }
    }
}