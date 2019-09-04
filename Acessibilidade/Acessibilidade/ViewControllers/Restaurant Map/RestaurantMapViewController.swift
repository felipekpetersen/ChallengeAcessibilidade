//
//  RestaurantMapViewController.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 02/09/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//  swiftlint:disable trailing_whitespace

import UIKit
import MapKit
import CoreLocation

class RestaurantMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var defaultCategoryLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var buttonCornerView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var restaurantMap: MKMapView!
    public var restaurantCodable: RestaurantCodable?
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCategoryLabels()
        setupCornerView()
        setupShadow()
        setupDescriptionLabel()
        setupMap()
    }
    
    @IBAction func myListButton(_ sender: Any) {
    }
    
    func setupCategoryLabels() {
        defaultCategoryLabel.text = "Como chegar no"
        restaurantNameLabel.text = restaurantCodable?.name
        descriptionLabel.text = restaurantCodable?.description
    }
    
    func setupCornerView() {
        cornerView.layer.cornerRadius = 22
        cornerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        buttonCornerView.layer.cornerRadius = 8
    }
    
    func setupShadow() {
        cornerView.addShadowWithBezier(color: .black, opacity: 0.4, offSet: .zero, radius: 20)
    }
    
    func setupDescriptionLabel() {
        
    }
    
    func setupMap() {
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: -23.547432, longitude: -46.651825)
        restaurantMap.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: CLLocationDistance(exactly: 700)!, longitudinalMeters: CLLocationDistance(exactly: 700)!)
        restaurantMap.region = region
//        restaurantMap.setRegion(mapView.regionThatFits(region), animated: true)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))

        self.locationManager.stopUpdatingLocation()

    }
    
}
