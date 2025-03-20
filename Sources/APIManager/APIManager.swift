// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation

public protocol Request {
    func request<T: Decodable & Sendable>(
        endPoint urlString: String,
        HttpMethod method: HTTPMethod,
        Parameter: [String: Any]?,
        header: [String: String]?, // Changed Any to String for safety
        completion: @escaping @Sendable (Result<T, Error>) -> Void
    )
}

public class APIManager: @unchecked Sendable,Request {

    public static let shared = APIManager()
    private let session:URLSession
    
    private init (session:URLSession = .shared){
        self.session = session
    }
    
    public func request<T>(endPoint urlString: String, HttpMethod method: HTTPMethod = .GET, Parameter: [String : Any]? = nil, header: [String : String]? = nil, completion: @escaping @Sendable (Result<T, any Error>) -> Void) where T : Decodable, T : Sendable {
        
        guard let url = URL(string: urlString) else{
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url,cachePolicy: .reloadIgnoringCacheData)
        request.httpMethod = method.rawValue
        
        if let header = header{
            for (key,value) in header{
                request.addValue("\(value)", forHTTPHeaderField: key)
            }
        }
        
        if let parameter = Parameter, method != .GET{
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: [])
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }catch {
                completion(.failure(error))
                return
            }
        }
        
        URLSession.shared.dataTask(with: request) { [self] data, response, error in
            let httpresponse = response as? HTTPURLResponse
            handleData(data: data, response: httpresponse, error: error, completion: completion)
        }.resume()
    }
    
    
    private func handleData<T: Decodable>(
           data: Data?,
           response: HTTPURLResponse?,
           error: Error?,
           completion: @escaping (Result<T, Error>) -> Void
       ){
           
           if let error = error {
               completion(.failure(error))
               return
           }
           
           guard let response = response,(200...299).contains(response.statusCode) else{
               let error = NSError(domain: "Invalid response", code: response?.statusCode ?? 500, userInfo: nil)
               completion(.failure(error))
               return
           }
           guard let data = data else {
               completion(.failure(NSError(domain: "No data recive", code: 500,userInfo: nil)))
               return
           }
           
           do {
               let decodeData = try JSONDecoder().decode(T.self, from: data)
               completion(.success(decodeData))
           }catch{
               completion(.failure(error))
           }
    }
}
