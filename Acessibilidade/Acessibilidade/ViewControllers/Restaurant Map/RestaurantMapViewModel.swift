//
//  RestaurantMapViewModel.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 03/09/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//  swiftlint:disable trailing_whitespace

import Foundation


class RestaurantMapViewModel{
    
    var categoryName: String?
    
    func getRestaurantsCategory(index: Int) -> String {
        return categoryName ?? ""
    }
}
