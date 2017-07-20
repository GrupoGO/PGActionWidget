//
//  ViewController.swift
//  ActionWidget
//
//  Created by Emilio Cubo Ruiz on 13/7/17.
//  Copyright © 2017 Grupo Go Optimizations, SL. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var widget: PGDActionWidgetView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // numberOfAction default is 10
        
        // MARK: - Ask for top actions
        widget.searchActions(keywords: nil, numberOfAction: nil)
        
        // MARK: -  Search for a tag
        // let keywords = ["fitness","health"]
        // widget.searchActions(keywords: keywords, numberOfAction: nil)
        
        // MARK: - Search for a location
        // let keywords = ["fitness","health"]
        // let location = CLLocationCoordinate2D(latitude: 41.397392, longitude: 2.195231)
        // widget.searchActions(coordinates: location, locationName: "PlayGround", keywords: keywords, numberOfAction: 150)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

