import Foundation


protocol NetworkServiceProtocol {
    func request<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void)
}

struct NetworkService: NetworkServiceProtocol {
    func request<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(.custom(description: error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                
                completion(.failure(.data))
                
                return
            }
            
            
            completion(.success(data as! T))
            
            
        }.resume()
    }
}

class DataRepository {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func gethUserData(completion: @escaping (Result<String, NetworkError>) -> Void) {
        
        guard let url = URL(string: AppConfiguration.userURL.url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        networkService.request(url: url) { (result: Result<Data, NetworkError>) in
            switch result {
            case .success(let data):
                
                do {
                    
                    if let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let title = jsonData["title"] as? String {
                        
                        completion(.success(title))
                        
                    } else {
                        completion(.failure(.custom(description: "Failed to parse JSON data")))
                    }
                    
                } catch {
                    completion(.failure(.custom(description: error.localizedDescription)))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
        
    }
    
    func getPlanetData(completion: @escaping (Result<PlanetData, NetworkError>) -> Void) {
        
        guard let url = URL(string: AppConfiguration.planetURL.url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        networkService.request(url: url) { (result: Result<Data, NetworkError>) in
            
            switch result {
            case .success(let data):
                
                do {
                    
                    let planetData = try JSONDecoder().decode(PlanetData.self, from: data)
                    completion(.success(planetData))
                    
                } catch {
                    completion(.failure(.custom(description: error.localizedDescription)))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
        
    }
}
