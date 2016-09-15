//
//  FriendAnnotation.swift
//  MapAssignment
//
//  Created by ycliang on 2016/9/15.
//  Copyright © 2016年 Alex Liang. All rights reserved.
//

import UIKit
import MapKit

class FriendAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var address: String
    var imageName: String
    var introduction: String
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, address: String, imageName: String, introduction: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.address = address
        self.imageName = imageName
        self.introduction = introduction
    }
}
