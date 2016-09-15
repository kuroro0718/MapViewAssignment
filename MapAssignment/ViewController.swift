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
}