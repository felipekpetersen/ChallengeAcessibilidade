//
//  MenuTableViewCell.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 04/09/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

protocol MenuTableViewCellDelegate {
    func receivePlate(restaurantName: String, plate: PlateCodable)
}

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    let plateCell = "PlateTableViewCell"
    var category = CategoryCodable()
    var isOpen: Bool?
    var delegate: MenuTableViewCellDelegate?
    var restaurantName: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cornerView.addShadow(color: .black, opacity: 0.1, offSet: .zero, radius: 4)
    }
    
    override func layoutSubviews() {
        self.tableView.layoutIfNeeded()
        self.tableView.reloadData()
        setupTableView()
        guard let name = categoryNameLabel.text else {return}
        if self.isOpen == false{
            self.accessibilityLabel = "Clique para abrir as opções de \(name))"
        } else {
            self.accessibilityLabel = "Clique para fechar as opções de \(name)"
        }
        print(self.accessibilityElements)
    }
    
    func setupCell(category: CategoryCodable, isOpen: Bool, restaurantName: String) {
        self.isOpen = isOpen
        categoryNameLabel.text = category.name
        self.category = category
        self.restaurantName = restaurantName
    }
    
    func setupCornerView(cornerRadius: CGFloat) {
        cornerView.layer.cornerRadius = cornerRadius
        cornerView.addShadow(color: .black, opacity: 0.2, offSet: CGSize(width: 0, height: 4), radius: 4)
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: plateCell, bundle: nil), forCellReuseIdentifier: plateCell)
        
        self.tableView.separatorStyle = .none
        if self.isOpen ?? false {
            self.tableView.isHidden = false
            self.tableViewHeight.constant = CGFloat((self.category.plates?.count ?? 0)) * 90
        } else {
            self.tableView.isHidden = true
            self.tableViewHeight.constant = 0
        }
    }
}

extension MenuTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.plates?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: plateCell, for: indexPath) as? PlateTableViewCell
        cell?.layoutSubviews()
        cell?.delegate = self
        cell?.layoutIfNeeded()
        cell?.setup(plate: self.category.plates?[indexPath.row] ?? PlateCodable(), restaurantName: restaurantName ?? String())
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension MenuTableViewCell:  PlateTableViewCellDelegate {
    func receivePlate(restaurantName: String, plate: PlateCodable) {
        self.delegate?.receivePlate(restaurantName: restaurantName, plate: plate)
    }
}
