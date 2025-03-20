//
//  File.swift
//  APIManager
//
//  Created by Suraj Bhujbal on 20/03/25.
//

import Foundation
import APIManager

fileprivate struct Product: Decodable, Sendable {
    var title: String
}

final public class APIManagerExample {
    
    private var ProductList: Product?
    
    public func getData() {
        APIManager.shared.request(
            endPoint: "https://fakestoreapi.com/products",
            completion: { (result: Result<Product, Error>) in
                switch result {
                case .success(let list):
                    print("User data: \(list)")
                    self.ProductList = list  // Store user data correctly
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        )
    }
    
    public func postData() {
        APIManager.shared.request(
            endPoint: "https://fakestoreapi.com/products",
            HttpMethod: .POST,
            parameters: [
                "id": 0,
                "title": "string",
                "price": 0.1,
                "description": "string",
                "category": "string",
                "image": "https://fakeimg.pl/300/"],
            
//            --> MARK  add  header if necessary
//            header: ["Content-Type": "application/json"],
            completion: { (result: Result<Product, Error>) in
                switch result {
                case .success(let list):
                    print("User created: \(user)")
                    self.ProductList = list  // Store user data correctly
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        )
    }
}
