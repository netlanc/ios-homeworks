import Foundation

enum AppConfiguration {
    case urlPeople (String)
    case urlStarships (String)
    case urlPlanets (String)
}

struct NetworkService {

        enum RequestError: LocalizedError {
            case invalidURL
            case failedToDecodeData
            
            var errorDescription: String? {
                switch self {
                case .invalidURL:
                    return "Некорректный URL"
                case .failedToDecodeData:
                    return "Не корректные данные"
                }
            }
        }
        
        static func request(for configuration: AppConfiguration, completion: @escaping (Result<String, Error>) -> Void) {
            
            var urlString: String
            
            switch configuration {
            case .urlPeople(let peopleURL):
                urlString = peopleURL
            case .urlStarships(let starshipsURL):
                urlString = starshipsURL
            case .urlPlanets(let planetsURL):
                urlString = planetsURL
            }
            
            guard let url = URL(string: urlString) else {
                completion(.failure(RequestError.invalidURL))
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let data = data {

                    if let resultString = String(data: data, encoding: .utf8) {

                        print("Data string: \(resultString)")
                        if let httpResponse = response as? HTTPURLResponse {

                            print("\nStatus Code: \(httpResponse.statusCode)")
                            print("\nHeaders: \(httpResponse.allHeaderFields)")
                        }
                        completion(.success(resultString))
                    } else {
                        completion(.failure(RequestError.failedToDecodeData))
                    }
                }
            }
            task.resume()
        }
}
