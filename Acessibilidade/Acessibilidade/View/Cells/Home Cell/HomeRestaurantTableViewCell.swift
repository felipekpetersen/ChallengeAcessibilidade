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
    @IBOutlet weak var backShadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    func setup(restaurant: RestaurantCodable?) {
        self.nameLabel.text = restaurant?.name
        self.addressLabel.text = restaurant?.place
        backShadowView.addShadow(color: .black, opacity: 0.25, offSet: .zero, radius: 8)
        if let id = restaurant?._id {
            let url = "https:guekavi-app.herokuapp.com/images/" + id + ".jpeg"
            self.backgroundImageView.imageFromServerURL(urlString: url )
        }
    }
}
