//
//  HomeRestaurantTableViewCell.swift
//  Acessibilidade
//
//  Created by Felipe Petersen on 02/09/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//  swiftlint:disable trailing_whitespace


import UIKit

class HomeRestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    func setup(restaurant: RestaurantCodable?) {
        self.nameLabel.text = restaurant?.name
        self.addressLabel.text = restaurant?.place
    }
    
}
