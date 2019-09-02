//
//  RestaurantMapViewController.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 02/09/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit
import MapKit

class RestaurantMapViewController: UIViewController {

    
    @IBOutlet weak var defaultCategoryLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var restaurantMap: MKMapView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCategoryLabels()
        setupCornerView()
        setupDescriptionLabel()

    }
    
    @IBAction func myListButton(_ sender: Any) {
    }
    
    func setupCategoryLabels() {
        
    }
    
    func setupCornerView() {
        
    }
    
    func setupDescriptionLabel(){
        
    }
}


extension RestaurantMapViewController: MKMapViewDelegate{
}

