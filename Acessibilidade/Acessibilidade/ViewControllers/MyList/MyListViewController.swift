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
        self.viewModel.getRestaurants()
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
        valueSubtotalLabel.text = self.viewModel.getTotalValue()
        subtotalLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        valueSubtotalLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
    //MARK:- Actions
    @IBAction func didTapTrash(_ sender: Any) {
        let alert = UIAlertController(title: "Deseja excluir todos os itens?", message: "Tem certeza que deseja remover todos os itens da sua lista?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Sim", style: .destructive, handler: { action in
            self.viewModel.cleanAllOrders()
            self.dismiss(animated: true, completion: nil)
            self.myListTableView.reloadData()
            self.setLabels()
        }))
        alert.addAction(UIAlertAction(title: "Não", style: .default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
    }
    
}

extension MyListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MyListManager.shared().getOrder()[section].plateCodable?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let restaurants = MyListManager.shared().getOrder()
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var restaurants = MyListManager.shared().getOrder()
        
        return restaurants[section].restaurantName

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.myListTableView.dequeueReusableCell(withIdentifier:
            listaCell, for: indexPath) as? MyListCellTableViewCell
        var orders = MyListManager.shared().getOrder()
//        var plates: [PlateCodable] = []
//        var plateName: String?
//        var price: String?

//        for inx in 0..<orders.count {
//            if let arrPlates = orders[inx].plateCodable{
//                plates.append(arrPlates[0])
//            }
//        }
        
        guard let plateName = orders[indexPath.section].plateCodable?[indexPath.row].name else {return UITableViewCell()}
        guard let price = orders[indexPath.section].plateCodable?[indexPath.row].price else {return UITableViewCell()}
        
        
        cell?.setUpCell(title: plateName, price: price)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            self.viewModel.deleteItemAt(indexPath: indexPath)
            self.myListTableView.reloadData()
            setLabels()
        }
    
    }
    
}
