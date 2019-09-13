//
//  RestaurantDetailsViewController.swift
//  Acessibilidade
//
//  Created by Juliana Vigato Pavan on 28/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//  swiftlint:disable trailing_whitespace

import UIKit

class RestaurantDetailsViewController: UIViewController{

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restauranteImgView: UIImageView!
    @IBOutlet weak var cardapiosTableView: UITableView!
    @IBOutlet weak var numberOfMenusLabel: UILabel!
    @IBOutlet weak var degardeView: UIView!
    @IBOutlet weak var smallTitleLabel: UILabel!
    @IBOutlet weak var backView: RoundedView!

    let viewModel = RestaurantDetailsViewModel()
    let cardapiosCell = "RestaurantDetailsTableViewCell"
    var restaurant = RestaurantCodable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setViews()
        setLabels()
        tabBarButton()
        viewModel.restaurant = self.restaurant
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setViews()
    }
    
    // MARK: - Setar table view
    func setTableView() {
        cardapiosTableView.delegate = self 
        cardapiosTableView.dataSource = self
        cardapiosTableView.register(UINib(nibName: cardapiosCell, bundle: nil), forCellReuseIdentifier: cardapiosCell)
        cardapiosTableView.separatorStyle = .none
    }
    
    func setViews() {
        degardeView.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.1254901961, blue: 0.2705882353, alpha: 1)
        degardeView.degrade(view: degardeView)
        backView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9607843137, blue: 0.9725490196, alpha: 1)
    }
    
    func setLabels() {
        restaurantNameLabel.textColor = #colorLiteral(red: 0.9490196078, green: 0.9607843137, blue: 0.9725490196, alpha: 1)
        restaurantNameLabel.font = UIFont.boldSystemFont(ofSize: 28.0)
        restaurantNameLabel.text = restaurant.name
        smallTitleLabel.textColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
        smallTitleLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        guard let restaurantsCount = restaurant.menus?.count else {return}
        if restaurantsCount > 1 {
            numberOfMenusLabel.text = "Há \(restaurantsCount) tipos de cárdapios"
        } else {
            numberOfMenusLabel.text = "Há \(restaurantsCount) tipo de cárdapio"
        }
        numberOfMenusLabel.font = UIFont.boldSystemFont(ofSize: 20)
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

extension RestaurantDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.cardapiosTableView.dequeueReusableCell(withIdentifier: cardapiosCell, for: indexPath) as? RestaurantDetailsTableViewCell
        let menu = self.viewModel.getMenu(row: indexPath.row)
        cell?.setUpCell(menu: menu)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuVC = MenuViewController()
        menuVC.menu = self.viewModel.getMenu(row: indexPath.row)
        menuVC.restaurant = self.viewModel.getRestaurant(restaurant: restaurant)
        self.navigationController?.pushViewController(menuVC, animated: true)
    }
}
