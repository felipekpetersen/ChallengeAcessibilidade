//
//  HomeViewModel.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 26/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//  swiftlint:disable trailing_whitespace

import Foundation
import CoreLocation

class HomeViewModel {
    
    var restaurants: [RestaurantCodable] = []
    var nearRestaurants: [RestaurantCodable] = []
    var restaurant = RestaurantCodable()
    var categories: [String] = []
    var restaurantsByCategory = [RestaurantCodable]()
    
    func getRestaurants() {
        restaurants = InternRestaurant.getRestaurant()
    }
    
    func getNearRestaurants(currentLocation: CLLocation) {
        for i in restaurants{
            guard let latitude = (i.latitude as NSString?)?.doubleValue else {return}
            guard let longitude = (i.longitude as NSString?)?.doubleValue else {return}
            let restaurantCoordinate = CLLocation(latitude: latitude, longitude: longitude)
            let distanceInMeters = restaurantCoordinate.distance(from: currentLocation)
            if distanceInMeters <= 1000{
                nearRestaurants.append(i)
            }
        }
    }
    
    func getMenu(restaurant: RestaurantCodable, row: Int) -> MenuCodable{
        return restaurant.menus?[row] ?? MenuCodable()
    }
    
    func numberOfRows() -> Int {
        return nearRestaurants.count
    }
    
    func getRestaurantForRow(row: Int) -> RestaurantCodable {
        return nearRestaurants[row]
    }
    
    func getCategoriesNumberOfRows() -> Int {
        self.categories.removeAll()
        for i in nearRestaurants{
            guard let categories = i.category else {return 0}
            for i in 0..<categories.count{
                self.categories.append(categories[i])
            }
        }
        return categories.count
    }
    
    func getCategoriesForRow(index: Int) -> String{
        return categories[index]
    }

    func separateCategories() {
        for restaurant in nearRestaurants {
            for category in restaurant.category ?? [] {
                if categories.contains(category) == false{
                    categories.append(category)
                }
            }
        }
    }
    
    func didChooseCategory(category: String) -> [RestaurantCodable] {
        for restaurant in nearRestaurants {
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
