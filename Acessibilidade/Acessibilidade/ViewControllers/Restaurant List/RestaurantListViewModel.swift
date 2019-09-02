//
//  RestaurantListViewModel.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 27/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import Foundation


class RestaurantListViewModel{
    
    var restaurants: [RestaurantCodable] = []
    
    func numberOfRows() -> Int {
        return self.restaurants.count
    }
    
    func restaurantForRow(index: Int) -> RestaurantCodable {
        return restaurants[index]
    }
    
}
