//
//  NearRestaurantTableViewCell.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 30/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//  swiftlint:disable trailing_whitespace

import UIKit


protocol NearRestaurantCellDelegate {
    func receiveMenu(restaurant: RestaurantCodable)
    func receiveDetail(restaurant: RestaurantCodable)
}

class NearRestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var openMenuView: UIView!
    @IBOutlet weak var openDetailsView: UIView!
    var restaurant: RestaurantCodable?
    var delegate: NearRestaurantCellDelegate?
    
    override var accessibilityTraits: UIAccessibilityTraits {
        get { return UIAccessibilityTraits.none }
        set {}
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        setupTapGesture()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupTapGesture()
    }
    
    func setup(restaurant: RestaurantCodable) {
        self.restaurantNameLabel.text = restaurant.name
        self.restaurant = restaurant
    }
    
    func setupCorner(cornerRadius: CGFloat) {
        self.cornerView.layer.cornerRadius =  cornerRadius
        self.cornerView.addShadow(color: .black, opacity: 0.25, offSet: CGSize(width: 0, height: 4), radius: 4)
    }
    
    func setupTapGesture() {
        setupAccessibility()
        
        let menuTap = UITapGestureRecognizer(target: self, action: #selector(openMenu))
        openMenuView.addGestureRecognizer(menuTap)
//        openMenuView.accessibilityTraits = .button
        
        let detailTap = UITapGestureRecognizer(target: self, action: #selector(openDetails))
        openDetailsView.addGestureRecognizer(detailTap)
//        openDetailsView.accessibilityTraits = .button
    }
    
    func setupAccessibility() {

        self.restaurantNameLabel.isAccessibilityElement = true
        self.restaurantNameLabel.accessibilityTraits = .staticText
        self.restaurantNameLabel.accessibilityLabel = self.restaurantNameLabel.text
        
        self.openMenuView.isAccessibilityElement = true
        self.openMenuView.accessibilityTraits = .button
        self.openMenuView.accessibilityLabel = "Entrar no restaurante"
        
        self.openDetailsView.isAccessibilityElement = true
        self.openDetailsView.accessibilityTraits = .button
        self.openDetailsView.accessibilityLabel = "Acessar localização"
    }
    
    @objc func openMenu() {
        guard let restaurant = restaurant else {return}
        delegate?.receiveMenu(restaurant: restaurant)
    }
    @objc func openDetails() {
        guard let restaurant = restaurant else {return}
        delegate?.receiveDetail(restaurant: restaurant)
    }
}
