//
//  PlateTableViewCell.swift
//  Acessibilidade
//
//  Created by Felipe Petersen on 04/09/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class PlateTableViewCell: UITableViewCell {

    @IBOutlet weak var plateNameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(plate: PlateCodable) {
        self.plateNameLabel.text = plate.name
        self.priceLabel.text = plate.price
    }
    
}
