//
//  NearRestaurantViewController.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 30/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//  swiftlint:disable trailing_whitespace

import UIKit

class NearRestaurantViewController: UIViewController {


    @IBOutlet weak var nearRestaurantLabel: UILabel!
    @IBOutlet weak var nearRestaurantTableView: UITableView!
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var categoryPhoto: UIImageView!
    @IBOutlet weak var defaultCategoryLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    let nearRestaurantCell = "NearRestaurantTableViewCell"
    let viewModel = NearRestaurantViewModel()
    var categoryName = ""
    var restaurants: [RestaurantCodable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.categoryName = self.categoryName
        self.viewModel.restaurants = self.restaurants
        setUpLabels()
        setupTableView()
        setupCategoryPhoto()
        setupCornerView()
        setUpViews()
        tabBarButton()
    }

    override func viewWillDisappear(_ animated: Bool) {
        
    }

    func setupTableView() {
        self.nearRestaurantTableView.delegate = self
        self.nearRestaurantTableView.dataSource = self
        self.nearRestaurantTableView.separatorStyle = .none
        nearRestaurantTableView.register(UINib(nibName: nearRestaurantCell, bundle: nil), forCellReuseIdentifier: nearRestaurantCell)
    }

    func setUpLabels() {
        categoryLabel.text = self.viewModel.getRestaurantsCategory(index: 0)
        self.defaultCategoryLabel.accessibilityLabel = "Categoria \(self.categoryName)"
        self.categoryLabel.isAccessibilityElement = false
        defaultCategoryLabel.text = "Categoria"
        if self.viewModel.restaurants.count > 1 {
            nearRestaurantLabel.text = "\(self.viewModel.restaurants.count) restaurantes próximos"
        } else {
            nearRestaurantLabel.text = "\(self.viewModel.restaurants.count) restaurante próximo"
        }
    }
    
    func setUpViews() {
        backView.degrade(view: backView)
        backView.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.1254901961, blue: 0.2705882353, alpha: 1)
    }
    
    func setupCategoryPhoto() {
        categoryPhoto.image = UIImage(named: "\(self.viewModel.getRestaurantsCategory(index: 0))-1")
    }
    
    func setupCornerView() {
        cornerView.layer.cornerRadius = 22
    }
    
    func tabBarButton() {
        let myListButton = UIBarButtonItem(image: UIImage(named: "Rectangle 4.5.png"), style: .plain, target: self, action: #selector(myListSender))
        myListButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = myListButton
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        myListButton.accessibilityLabel = "Acessar lista de compras"
    }
    
    @objc func myListSender() {
        let myListVC = MyListViewController()
        self.navigationController?.pushViewController(myListVC, animated: true)
    }
}

extension NearRestaurantViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.nearRestaurantTableView.dequeueReusableCell(withIdentifier: nearRestaurantCell, for: indexPath) as? NearRestaurantTableViewCell
        cell?.setup(restaurant: self.viewModel.getRestaurants(index: indexPath.row))
        cell?.setupCorner(cornerRadius: 5)
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
}

extension NearRestaurantViewController: NearRestaurantCellDelegate {
    func receiveMenu(restaurant: RestaurantCodable) {
        let restaurantDetailsVC = RestaurantDetailsViewController()
        let menuVC = MenuViewController()
        let menu = self.viewModel.getMenu(restaurant: restaurant, row: 0)
        restaurantDetailsVC.restaurant = restaurant
        guard let numberOfMenus = restaurant.menus?.count else {return}
        if numberOfMenus == 1 {
            menuVC.menu = menu
            menuVC.restaurant = restaurant
            navigationController?.pushViewController(menuVC, animated: true)
        } else {
            navigationController?.pushViewController(restaurantDetailsVC, animated: true)
        }
    }
    
    func receiveDetail(restaurant: RestaurantCodable) {
        let restaurantMapVC = RestaurantMapViewController()
        restaurantMapVC.restaurantCodable = restaurant
        navigationController?.pushViewController(restaurantMapVC, animated: true)
    }
}
