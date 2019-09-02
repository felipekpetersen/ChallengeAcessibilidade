//
//  HomeViewModel.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 26/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    var restaurants: [RestaurantCodable] = []
    var categories: [String] = []
    
    func getRestaurants() {
        restaurants = InternRestaurant.getRestaurant()
    }
    
    func numberOfRows() -> Int {
        return restaurants.count
    }
    
    func getRestaurantForRow(row: Int) -> RestaurantCodable {
        return restaurants[row]
    }
    
    func getCategoriesNumberOfRows() -> Int{
        return categories.count
    }
    
    func getCategoriesForRow(index: Int) -> String{
        return categories[index]
    }
    
    func separateCategories() {
        for restaurant in restaurants {
            for category in restaurant.category ?? [] {
                if categories.contains(category) == false{
                    categories.append(category)
                }
            }
        }
    }
    
}
