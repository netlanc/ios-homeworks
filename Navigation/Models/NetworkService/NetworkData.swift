import Foundation

struct UserData: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

enum AppConfiguration: String, CaseIterable {
    case peopleURL = "https://swapi.dev/api/people"
    case starshipsURL = "https://swapi.dev/api/starships"
    case planetsURL = "https://swapi.dev/api/planets"
    case userURL = "https://jsonplaceholder.typicode.com/todos/2/"
    
    var url: String {
            return self.rawValue
        }
}

enum NetworkError: Error {
    case custom(description: String)
    case server
    case data
    case unknown
    case invalidURL
}
