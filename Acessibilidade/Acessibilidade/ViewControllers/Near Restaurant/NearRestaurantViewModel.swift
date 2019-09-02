//
//  NearRestaurantViewModel.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 30/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import Foundation


class NearRestaurantViewModel{
    
    var restaurants: [RestaurantCodable] = []
    var categoryName: String?
    
    func getRestaurants(index: Int) -> RestaurantCodable {
        return restaurants[index]
    }
    
    func getRestaurantsCategory(index: Int) -> String {
        return categoryName ?? ""
    }
    
    func numberOfRows() -> Int {
        return restaurants.count
    }
    
}

