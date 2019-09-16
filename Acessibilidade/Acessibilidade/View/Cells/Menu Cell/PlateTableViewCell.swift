//
//  PlateTableViewCell.swift
//  Acessibilidade
//
//  Created by Felipe Petersen on 04/09/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

protocol PlateTableViewCellDelegate {
    func receivePlate(restaurantName: String, plate: PlateCodable)
}

class PlateTableViewCell: UITableViewCell {

    @IBOutlet weak var plateNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addPlateView: UIView!
    
    @IBOutlet weak var apimentadoView: UIView!
    @IBOutlet weak var glutenView: UIView!
    @IBOutlet weak var lactoseView: UIView!
    @IBOutlet weak var veganoView: UIView!
    @IBOutlet weak var vegetarianoView: UIView!
    
    var delegate: PlateTableViewCellDelegate?
    var restaurant: RestaurantCodable?
    var restaurantName: String?
    var plate: PlateCodable?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupTapGesture()
//        self.hideAllRestricoes()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAccessibility()
    }

    func setup(plate: PlateCodable, restaurantName: String) {
        self.plateNameLabel.text = plate.name
        self.priceLabel.text = plate.price
        self.plate = plate
        self.restaurantName = restaurantName
//        self.setupRestricoes(tag: plate.tag)
    }
    
    func hideAllRestricoes() {
        self.apimentadoView.isHidden = true
        self.glutenView.isHidden = true
        self.lactoseView.isHidden = true
        self.veganoView.isHidden = true
        self.vegetarianoView.isHidden = true
    }
    
    func setupRestricoes(tag: [String]?) {
        if let tags = tag, tags.isEmpty == false {
            for tag in tags {
                if tag == "Apimentado" {
                    self.apimentadoView.isHidden = false
                } else if tag == "Gluten" {
                    self.glutenView.isHidden = false
                } else if tag == "Lactose" {
                    self.lactoseView.isHidden = false
                } else if tag == "Vegano" {
                    self.veganoView.isHidden = false
                } else if tag == "Vegetariano" {
                    self.vegetarianoView.isHidden = false
                }
            }
        }
    }
    
    func setupTapGesture() {
        let addPlateTap = UITapGestureRecognizer(target: self, action: #selector(addPlate))
        addPlateView.addGestureRecognizer(addPlateTap)
    }
    
    @objc func addPlate(){
        guard let plate = plate else {return}
        delegate?.receivePlate(restaurantName: restaurantName ?? String(), plate: plate)
    }
    
    func setupAccessibility() {
        self.plateNameLabel.isAccessibilityElement = true
        self.plateNameLabel.accessibilityTraits = .staticText
        self.plateNameLabel.accessibilityLabel = self.plateNameLabel.text
        
        self.priceLabel.isAccessibilityElement = true
        self.priceLabel.accessibilityTraits = .staticText
        self.priceLabel.accessibilityLabel = self.priceLabel.text
        
        self.addPlateView.isAccessibilityElement = true
        self.addPlateView.accessibilityTraits = .button
        self.addPlateView.accessibilityLabel = "Adicionar aos pedidos"
    }
}
