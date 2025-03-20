//
//  File.swift
//  APIManager
//
//  Created by Suraj Bhujbal on 20/03/25.
//

import Foundation

public struct Product: Decodable, Sendable {
    let id: Int?
    let title: String?
    let price: Double?
    let description: String?
    let category: String?
    let image: String?
    
}


public final class APIManagerExample : @unchecked Sendable{
    
    private var ProductList: [Product]?
    private var postProductList:Product?
    
     public init() {}
     
    public func getData() {
        APIManager.shared.request(
            endPoint: "https://fakestoreapi.com/products",
            completion: { (result: Result<[Product], Error>) in
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
            Parameter: [
                "id": 0,
                "title": "Hey",
                "price": 0.3,
                "description": "New",
                "category": "DJJ",
                "image": "https://fakeimg.pl/300/"],
            
//            --> MARK  add  header if necessary
//            header: ["Content-Type": "application/json"],
            completion: { (result: Result<Product, Error>) in
                switch result {
                case .success(let list):
                    print("User created: \(list)")
                    self.postProductList = list  // Store user data correctly
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        )
    }
}
