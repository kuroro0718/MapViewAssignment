//
//  FriendViewController.swift
//  MapAssignment
//
//  Created by ycliang on 2016/9/15.
//  Copyright © 2016年 Alex Liang. All rights reserved.
//

import UIKit

class FriendViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var introTextView: UITextView!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var imageName = ""
    var name = ""
    var introduction = ""
    var distance: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImageView.image = UIImage(named: imageName)
        nameLabel.text = name
        introTextView.text = introduction
        
        let distanceString = String(format: "%.3f", distance)
        distanceLabel.text = "Distance from user: " + distanceString + "M"
        
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
