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
    @IBOutlet weak var openMapLabel: UILabel!
    @IBOutlet weak var restaurantMap: MKMapView!
    public var restaurantCodable: RestaurantCodable?
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCategoryLabels()
        setupCornerView()
        setupShadow()
        tabBarButton()
        setupMapLabel()
        setupMap()
        setupTapGesture()
    }
    
    func setupCategoryLabels() {
        defaultCategoryLabel.text = "Como chegar no restaurante"
        defaultCategoryLabel.isAccessibilityElement = true
        defaultCategoryLabel.accessibilityTraits = .staticText
        restaurantNameLabel.text = restaurantCodable?.name
        restaurantNameLabel.isAccessibilityElement = false
        descriptionLabel.text = restaurantCodable?.description
    }
    
    func setupMapLabel() {
        openMapLabel.isAccessibilityElement = true
        openMapLabel.accessibilityTraits = .button
        openMapLabel.accessibilityHint = "Ira abrir o aplicativo mapas"
    }
    
    func setupCornerView() {
        cornerView.layer.cornerRadius = 22
        cornerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        buttonCornerView.layer.cornerRadius = 8
    }
    
    func setupShadow() {
        cornerView.addShadowWithBezier(color: .black, opacity: 0.4, offSet: .zero, radius: 30)
        buttonCornerView.addShadow(color: .black, opacity: 0.25, offSet: CGSize(width: 0, height: 4), radius: 4)
    }
    
    func setupMap() {
        let annotation = MKPointAnnotation()
        let latitude = (restaurantCodable?.latitude as NSString?)?.doubleValue
        let longitude = (restaurantCodable?.longitude as NSString?)?.doubleValue
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude ?? 0, longitude: longitude ?? 0)
        restaurantMap.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: CLLocationDistance(exactly: 700)!, longitudinalMeters: CLLocationDistance(exactly: 700)!)
        restaurantMap.region = region
        restaurantMap.isAccessibilityElement = false
        restaurantMap.accessibilityElementsHidden = true
        
//        restaurantMap.setRegion(mapView.regionThatFits(region), animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        self.locationManager.stopUpdatingLocation()
    }
    
    func tabBarButton() {
        let myListButton = UIBarButtonItem(image: UIImage(named: "Rectangle 4.5.png"), style: .plain, target: self, action: #selector(myListSender))
        myListButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = myListButton
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)

    }
    
    func setupTapGesture() {
        let openMapTap = UITapGestureRecognizer(target: self, action: #selector(openMap))
        buttonCornerView.addGestureRecognizer(openMapTap)
    }
    
    @objc func openMap() {
        let latitude = (restaurantCodable?.latitude as NSString?)?.doubleValue
        let longitude = (restaurantCodable?.longitude as NSString?)?.doubleValue
        let coordinates = CLLocationCoordinate2D(latitude: latitude ?? 0, longitude: longitude ?? 0)
        let regionDistance: CLLocationDistance = 700
        let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: CLLocationDistance(exactly: 700)!, longitudinalMeters: CLLocationDistance(exactly: 700)!)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: region.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: region.span)
        ]
        
        let placeMark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placeMark)
        guard let restaurantName = restaurantCodable?.name else {return}
        mapItem.name = "\(restaurantName)"
        mapItem.openInMaps(launchOptions: options)
    }
    
    @objc func myListSender() {
        let myListVC = MyListViewController()
        self.navigationController?.pushViewController(myListVC, animated: true)
    }
    
    func setUpNavigationBar() {
        
    }
}
