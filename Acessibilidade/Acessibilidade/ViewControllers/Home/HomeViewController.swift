//
//  HomeViewController.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 26/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//  swiftlint:disable trailing_whitespace

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoriasTeste: UILabel!
    @IBOutlet weak var restaurantesProximosTeste: UILabel!
    
    var locationManager : CLLocationManager = CLLocationManager()
    //@IBOutlet weak var myListButton: UIButton!
    //    private let itemsPerRow
    
    let viewModel = HomeViewModel()
    let restaurantCell = "HomeRestaurantTableViewCell"
    let categoriesCell = "CategoriesRestaurantsCollectionViewCell"
    private var sectionInsets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
    private let itemsPerRow: CGFloat = 4

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCollectionView()
        setupShadow()
        tabBarButton()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.getRestaurants()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.cleanCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupLabels()

    }
    
    func getRestaurants() {
        self.viewModel.getRestaurants()
        self.viewModel.separateCategories()
        self.tableView.reloadData()
    }
    
    // MARK: - Setups
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: restaurantCell, bundle: nil), forCellReuseIdentifier: restaurantCell)
        self.tableView.separatorStyle = .none
    }
    
    func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.isAccessibilityElement = true
        collectionView.register(UINib(nibName: categoriesCell, bundle: nil), forCellWithReuseIdentifier: categoriesCell)
        self.collectionView.isAccessibilityElement = false 
    }
    
    func setupLabels() {
        self.categoriasTeste.text = "\(self.viewModel.getCategoriesNumberOfRows()) Categorias perto de você"
        self.restaurantesProximosTeste.text = "\(self.viewModel.numberOfRows()) restaurantes próximos a você"
    }
    
    func setupShadow() {
        searchView.addShadowWithBezier(color: .black, opacity: 0.4, offSet: .zero, radius: 30)
    }
    
    // MARK: - Actions
    func tabBarButton() {
        let myListButton = UIBarButtonItem(image: UIImage(named: "Rectangle 4.5.png"), style: .plain, target: self, action: #selector(myListSender))
        myListButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = myListButton
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)

    }
    
    @objc func myListSender() {
        let myListVC = MyListViewController()
        self.navigationController?.pushViewController(myListVC, animated: true)
    }
    
    // MARK: - Location
    func setupGeoFence() {
        let geofenceRegionCenter = CLLocationCoordinate2DMake(-38.028308, -57.531508);
        let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter, radius: 400, identifier: "CurrentLocation");
        geofenceRegion.notifyOnExit = true;
        geofenceRegion.notifyOnEntry = true;
        
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            setupGeoFence()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }

}

// MARK: - Table View Delegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: restaurantCell, for: indexPath) as? HomeRestaurantTableViewCell
        cell?.setup(restaurant: self.viewModel.getRestaurantForRow(row: indexPath.row))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = RestaurantDetailsViewController()
        vc.restaurant = self.viewModel.getRestaurantForRow(row: indexPath.row)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCategoriesNumberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: categoriesCell, for: indexPath) as? CategoriesRestaurantsCollectionViewCell
        cell?.setup(color: #colorLiteral(red: 0.7529411765, green: 0.831372549, blue: 0.9098039216, alpha: 1), titulo: self.viewModel.getCategoriesForRow(index: indexPath.row))
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 124, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = NearRestaurantViewController()
        
        vc.restaurants = self.viewModel.didChooseCategory(category: self.viewModel.getCategoriesForRow(index: indexPath.row))
        vc.categoryName = self.viewModel.getCategoriesForRow(index: indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
//        let vc = SelectPlateModalViewController()
//        vc.modalTransitionStyle = .coverVertical
//        vc.modalPresentationStyle = .overCurrentContext
//        self.present(vc, animated: true, completion: nil)
    }
}
