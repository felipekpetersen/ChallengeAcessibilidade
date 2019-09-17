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
    var currentLocation: CLLocation?
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
        setupLocationManager()
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
        if self.viewModel.categories.count > 1 {
            self.categoriasTeste.text = "\(self.viewModel.getCategoriesNumberOfRows()) Categorias perto de você"
            self.restaurantesProximosTeste.text = "\(self.viewModel.numberOfRows()) restaurantes próximos a você"
        } else {
            self.categoriasTeste.text = "\(self.viewModel.getCategoriesNumberOfRows()) Categoria perto de você"
            self.restaurantesProximosTeste.text = "\(self.viewModel.numberOfRows()) Restaurante próximo a você"
        }
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
        myListButton.accessibilityLabel = "Acessar lista de compras"
        myListButton.accessibilityTraits = .none
    }
    
    @objc func myListSender() {
        let myListVC = MyListViewController()
        self.navigationController?.pushViewController(myListVC, animated: true)
    }
    
    // MARK: - Location
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func setupGeoFence() {
        currentLocation = locationManager.location
        locationManager.startUpdatingLocation()
        let latitude = -23.547110
        let longitude = -46.649900
        let myLocation = CLLocation(latitude: latitude, longitude: longitude)
        guard let currentLocation = currentLocation else {return}
        viewModel.getNearRestaurants(currentLocation: myLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            setupGeoFence()
            self.collectionView.reloadData()
            self.tableView.reloadData()
            self.setupLabels()
        }
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
        let menuVC = MenuViewController()
        let restaurant = self.viewModel.getRestaurantForRow(row: indexPath.row)
        let menu = self.viewModel.getMenu(restaurant: restaurant, row: 0)
        guard let numberOfMenus = restaurant.menus?.count else {return}
        if numberOfMenus == 1{
            menuVC.menu = menu
            menuVC.restaurant  = restaurant
            self.navigationController?.pushViewController(menuVC, animated: true)
        }else{
            vc.restaurant = restaurant
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
