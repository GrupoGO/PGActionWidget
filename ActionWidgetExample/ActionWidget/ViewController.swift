//
//  ViewController.swift
//  ActionWidget
//
//  Created by Emilio Cubo Ruiz on 13/7/17.
//  Copyright © 2017 Grupo Go Optimizations, SL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var widget: PGDActionWidgetView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // numberOfAction default is 10
        
        // MARK: - Ask for top actions
        widget.searchAction(text: nil, numberOfAction: nil)
        
        // MARK: -  Search for Search for a tag
        // widget.searchAction(text: "your tag here", numberOfAction: nil)

        // MARK: -  Search for Search for a tag
        // widget.searchAction(text: nil, numberOfAction: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

