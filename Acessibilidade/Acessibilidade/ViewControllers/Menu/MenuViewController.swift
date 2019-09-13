//
//  MenuViewController.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 04/09/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numberOfCategorysLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var degradeView: UIView!
    
    public var restaurant = RestaurantCodable()
    public var menu = MenuCodable()
    var viewModel = MenuViewModel()
    let menuCell = "MenuTableViewCell"
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupLabels()
        tabBarButton()
        setViews()
        viewModel.menu = menu
    }
    
    override func viewDidLayoutSubviews() {
        self.tableView.layoutIfNeeded()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        tableView.register(UINib(nibName: menuCell, bundle: nil), forCellReuseIdentifier: menuCell)
    }
    
    func setupLabels() {
        restaurantNameLabel.text = restaurant.name
        categoryNameLabel.text = menu.name
        guard let numberOfCategorys = restaurant.menus?.count else {return}
        if numberOfCategorys == 1{
            numberOfCategorysLabel.text = "Há \(numberOfCategorys) categoria de pratos"
        } else{
            numberOfCategorysLabel.text = "Há \(numberOfCategorys) categorias de pratos"
        }
    }
    
    func setViews() {
        degradeView.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.1254901961, blue: 0.2705882353, alpha: 1)
        degradeView.degrade(view: degradeView)
        backView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9607843137, blue: 0.9725490196, alpha: 1)
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

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: menuCell, for: indexPath) as? MenuTableViewCell
        let category = self.viewModel.getCategory(row: indexPath.row)
        cell?.setupCell(category: category, isOpen: self.selectedIndex == indexPath.row ? true : false, restaurantName: restaurant.name ?? String())
        cell?.setupCornerView(cornerRadius: 5)
        cell?.layoutSubviews()
        cell?.layoutIfNeeded()
        cell?.selectionStyle = .none
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.selectedIndex == indexPath.row {
            self.selectedIndex = nil
        } else {
            self.selectedIndex = indexPath.row
        }
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath], with: .fade)
        self.tableView.endUpdates()
    }
}

extension MenuViewController:  MenuTableViewCellDelegate {
    func receivePlate(restaurantName: String, plate: PlateCodable) {
        let vc = SelectPlateModalViewController()
        vc.delegate = self
        vc.restaurantName = restaurantName
        vc.plate = plate
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
}

extension MenuViewController: SelectPlateModalViewControllerDelegate {
    func didTapOpenPlates() {
        let myListVC = MyListViewController()
        self.navigationController?.pushViewController(myListVC, animated: true)
    }
    
    func didTapOtherMenu() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

