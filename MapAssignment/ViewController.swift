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
    var userLocation: CLLocation?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager.requestWhenInUseAuthorization()
        
        // Add Friend's annotation
        let firstAnnotation = FriendAnnotation(coordinate: CLLocationCoordinate2D(latitude: 25.078489, longitude: 121.575207), title: "Alex", subtitle: "Friend1", address: "台北市內湖區洲子街12號", imageName: "alex", introduction: "Alex Rodriguez，紐約洋基隊球員，美國職棒最具人氣的球星之一，也是洋基隊最具影響力的球員，是一位全方位的超級強打者。無論是打擊率、全壘打、盜壘、打點、守備，通通都有一定的水準，實力是大聯盟公認的最高等級，早在年輕高校時期的時候，就已經有不少支球團看上他的球技，1993年加入水手隊時，以最年輕的年紀加入美國職棒，只花一年的時間就迅速升上大聯盟，慢慢站穩固定先發位置，在水手隊打出了名氣之後，經紀人Scott Boras就順勢開始他的高薪之旅，年年都打破單季年薪紀錄，遊騎兵隊更是看上他的實力，不惜花出10年2億5200萬的超級合約，綁住A-Rod。")
        self.mapView.addAnnotation(firstAnnotation)
        
        let secondAnnotation = FriendAnnotation(coordinate: CLLocationCoordinate2D(latitude: 25.067138, longitude: 121.660261), title: "John", subtitle: "Friend2", address: "新北市汐止區汐科路321號", imageName: "john", introduction: "強尼·戴蒙（Johnny Damon，1973年11月5日－）為美國的棒球選手之一，曾經效力於美國職棒大聯盟皇家隊、運動家隊、紅襪隊、洋基隊、老虎隊、光芒及印地安人等球隊。戴蒙因為有著不錯的打擊能力，於2006年代表美國參加第一屆世界棒球經典賽、2013年則是代表泰國參加第三屆世界棒球經典賽資格賽。")
        self.mapView.addAnnotation(secondAnnotation)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showFriendProfile" {
            let vc = segue.destinationViewController as! FriendViewController
                        
            vc.name = (sender as! FriendAnnotation).title!
            vc.imageName = (sender as! FriendAnnotation).imageName
            vc.introduction = (sender as! FriendAnnotation).introduction
        }
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        if self.isFirstLocation == false {
            self.isFirstLocation = true
            self.userLocation = userLocation.location
            
            let region = MKCoordinateRegion(center: userLocation.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            mapView.setRegion(region, animated: true)                        
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
        let location = CLLocation(latitude: (annotation?.coordinate.latitude)!, longitude: (annotation?.coordinate.longitude)!)
        let distance = location.distanceFromLocation(self.userLocation!)
        
        if let title = annotation?.title {
            print("The distance from \(title!)'s home is \(distance)M")
            
            performSegueWithIdentifier("showFriendProfile", sender: annotation)            
        }
    }
}