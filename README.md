# APIManager 🚀

APIManager is a lightweight and easy-to-use API calling framework in Swift.
---
## 📌 Installation

### **Using Swift Package Manager (SPM)**  
1. Open Xcode and go to **File > Add Packages**.  
2. Enter the repository URL:**https://github.com/SurajBhujbal/APIManager**
3. Choose the latest version and click **Add Package**.  

---

## 🚀 Usage

### **Step 1️⃣: Define a Model**
Your model must conform to `Decodable & Sendable`.


 **struct UserModel: Decodable, Sendable {**
 `swift
 let id: Int
 let name: String
}`


### **Step 2️⃣: Import APIManager**
Make sure you import APIManager in your Swift file.

**import APIManager**

### **Step 3️⃣: Make an API Call**
Call an API using APIManager.shared.request.

## 📌 Example API Call

You can make an API request using `APIManager.shared.request` like this:

`swift
func Call() {
    APIManager.shared.request(endPoint: "https://api.example.com/user") { 
        (res: Result<UserModel, Error>) in
        switch res {
        case .success(let data):
            print("✅ Success:", data)
            // Bind your data here...!
        case .failure(let error):
            print("❌ Error:", error.localizedDescription)
        }
    }
}`

