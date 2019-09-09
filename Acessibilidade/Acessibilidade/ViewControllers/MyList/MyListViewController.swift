//
//  MyListViewController.swift
//  Acessibilidade
//
//  Created by Juliana Vigato Pavan on 27/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//  swiftlint:disable trailing_whitespace

import UIKit

class MyListViewController: UIViewController {
    
    @IBOutlet weak var listTitleLabel: UILabel!
    @IBOutlet weak var myListTableView: UITableView!
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var valueSubtotalLabel: UILabel!
    @IBOutlet weak var myListImageView: UIImageView!
    @IBOutlet weak var subtotalView: RoundedView!
    @IBOutlet weak var degradeView: UIView!
    
    let viewModel = MyListViewModel()
    let listaCell = "MyListCellTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setViews()
        setLabels()
    }
    
    func setTableView(){
        self.myListTableView.delegate = self
        self.myListTableView.dataSource = self
        myListTableView.register(UINib(nibName: listaCell, bundle:  nil), forCellReuseIdentifier: listaCell)
        myListTableView.separatorStyle = .none
    }
    
    func setViews(){
//        subtotalView.addShadowWithBezier(color: .black, opacity: 1, offSet: .zero, radius: 30)
        degradeView.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.1254901961, blue: 0.2705882353, alpha: 1)
        degradeView.degrade(view: degradeView)
        myListImageView.image = UIImage(named: "pizzaPlaceholder")
        subtotalView.backgroundColor = #colorLiteral(red: 0.7529411765, green: 0.831372549, blue: 0.9098039216, alpha: 1)
    }
    
    func setLabels(){
        listTitleLabel.text = "Lista de compras"
        listTitleLabel.font = UIFont.boldSystemFont(ofSize: 28.0)
        listTitleLabel.textColor = #colorLiteral(red: 0.9490196078, green: 0.9607843137, blue: 0.9725490196, alpha: 1)
        subtotalLabel.text = "Subtotal"
        subtotalLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        valueSubtotalLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
}

extension MyListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var restaurants = MyListManager.shared().getOrder()
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var restaurants = MyListManager.shared().getOrder()
        var restaurantName: String?
        for inx in restaurants {
            restaurantName = inx.restaurantName ?? String()
        }
        return restaurantName

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.myListTableView.dequeueReusableCell(withIdentifier:
            listaCell, for: indexPath) as? MyListCellTableViewCell
        var restaurants = MyListManager.shared().getOrder()
        var plates: [PlateCodable] = []
//        var plateName: String?
//        var price: String?

        for inx in 0..<restaurants.count {
            plates = restaurants[inx].plateCodable ?? [PlateCodable()]
        }
        
        guard let plateName = plates[indexPath.row].name else {return UITableViewCell()}
        guard let price = plates[indexPath.row].price else {return UITableViewCell()}
        
        
        cell?.setUpCell(title: plateName, price: price)
        
        return cell ?? UITableViewCell()
    }
}
