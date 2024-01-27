import Foundation

struct NetworkService {
        
        static func request(url: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
            
            guard let url = URL(string: url) else {
                completion(.failure(.invalidURL))
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(.custom(description: error.localizedDescription)))
                    return
                }
                
                guard let data else {
                    DispatchQueue.main.async {
                        completion(.failure(.data))
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            }
            task.resume()
        }
}
