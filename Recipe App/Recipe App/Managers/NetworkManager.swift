//
//  NetworkManager.swift
//  Recipe App
//
//  Created by meekam okeke on 1/11/22.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared   = NetworkManager()
    private let baseURL = "https://www.themealdb.com/api/json/v1/1/categories.php"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    /// This function is responsible for fetching and parsing the data for the list of Categories.
    func fetchMealCategories(completed: @escaping (Result<[Category], RAError>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completed(.failure(.unableToComplete))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let categories = try decoder.decode(FoodCategory.self, from: data)
                let sortedCategories = categories.categories.sorted { a, b in
                    return a.strCategory < b.strCategory
                }
                completed(.success(sortedCategories))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    ///This function is responsible for fetching and parsing the data for the list of meals in each category.
    func fetchListOfMeals(for category: String, completed: @escaping(Result<Meals, RAError>) -> Void) {
        let _url = "https://www.themealdb.com/api/json/v1/1/filter.php?"
        let endPoint = _url + "c=\(category)"
        guard let url = URL(string: endPoint) else {
            completed(.failure(.unableToComplete))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let meals = try decoder.decode(Meals.self, from: data)
                completed(.success(meals))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    ///This function is responsible for fetching and parsing the data for meal recipe.
    func fetchMealDetails(for ID: String, completed: @escaping(Result<Recipes, RAError>) -> Void ) {
        let _url = "https://www.themealdb.com/api/json/v1/1/lookup.php?"
        let endPoint = _url + "i=\(ID)"
        guard let url = URL(string: endPoint) else {
            completed(.failure(.unableToComplete))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let recipes = try decoder.decode(Recipes.self, from: data)
                completed(.success(recipes))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    ///This function is responsible for fetching and parsing image data
    func downloadImage(from urlString: String, completed: @escaping(UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
}
