//
//  MenuTableViewCell.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 04/09/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    let plateCell = "PlateTableViewCell"
    var category = CategoryCodable()
    var isOpen: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cornerView.addShadow(color: .black, opacity: 0.1, offSet: .zero, radius: 4)
    }
    
    override func layoutSubviews() {
        self.tableView.layoutIfNeeded()
        setupTableView()
    }
    
    func setupCell(category: CategoryCodable, isOpen: Bool){
        self.isOpen = isOpen
        categoryNameLabel.text = category.name
        self.category = category
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
            self.tableViewHeight.constant = CGFloat((self.category.plates?.count ?? 0)) * 60
        } else {
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
        
        cell?.layoutIfNeeded()
        
//        cell?.setup(plate: self.category.plates?[indexPath.row] ?? PlateCodable())
        return cell ?? UITableViewCell()
    }
}
