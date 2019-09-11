//
//  HomeViewModel.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 26/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//  swiftlint:disable trailing_whitespace

import Foundation

class HomeViewModel {
    
    var restaurants: [RestaurantCodable] = []
    var restaurant = RestaurantCodable()
    var categories: [String] = []
    var restaurantsByCategory = [RestaurantCodable]()
    
    func getRestaurants() {
        restaurants = InternRestaurant.getRestaurant()
    }
    
    func getMenu(restaurant: RestaurantCodable, row: Int) -> MenuCodable{
        return restaurant.menus?[row] ?? MenuCodable()
    }
    
    func numberOfRows() -> Int {
        return restaurants.count
    }
    
    func getRestaurantForRow(row: Int) -> RestaurantCodable {
        return restaurants[row]
    }
    
    func getCategoriesNumberOfRows() -> Int {
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
    
    func didChooseCategory(category: String) -> [RestaurantCodable] {
        for restaurant in restaurants {
            for restaurantCategory in restaurant.category ?? []{
                if category == restaurantCategory {
                    restaurantsByCategory.append(restaurant)
                }
            }
        }
        return restaurantsByCategory
    }
    
    func cleanCategories() {
        restaurantsByCategory.removeAll()
    }
}
