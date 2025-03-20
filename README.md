# APIManager 🚀

APIManager is a lightweight and easy-to-use API calling framework in Swift.
---
## 📌 Installation

### **Using Swift Package Manager (SPM)**  
1. Open Xcode and go to **File > Add Packages**.  
2. Enter the repository URL:**https://github.com/SurajBhujbal/API_Manager**
3. Choose the latest version and click **Add Package**.  

---

## 🚀 Usage

### **Step 1️⃣: Define a Model**
Your model must conform to `Decodable & Sendable`.

```swift
public struct Product: Decodable, Sendable {
    let id: Int?
    let title: String?
    let price: Double?
    let description: String?
    let category: String?
    let image: String?
    
}
```

### **Step 2️⃣: Import APIManager**
Make sure you import APIManager in your Swift file.

```swift
import APIManager
```

### **Step 3️⃣: Make an API Call**
Call an API using APIManager.shared.request.

## 📌 Example API Call

You can make an API request using `APIManager.shared.request` like this:

```swift
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

```

