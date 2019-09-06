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
    var delegate: PlateTableViewCellDelegate?
    var restaurant: RestaurantCodable?
    var restaurantName: String?
    var plate: PlateCodable?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTapGesture()

        // Initialization code
    }

    func setup(plate: PlateCodable, restaurantName: String) {
        self.plateNameLabel.text = plate.name
        self.priceLabel.text = plate.price
        self.plate = plate
        self.restaurantName = restaurantName
    }
    
    func setupTapGesture() {
        let addPlateTap = UITapGestureRecognizer(target: self, action: #selector(addPlate))
        addPlateView.addGestureRecognizer(addPlateTap)
    }
    
    @objc func addPlate(){
        guard let plate = plate else {return}
        delegate?.receivePlate(restaurantName: restaurantName ?? String(), plate: plate)
    }
}
