import Foundation

struct PlanetData: Decodable {
    let name, rotationPeriod, orbitalPeriod, diameter: String
    let climate, gravity, terrain, surfaceWater: String
    let population: String
    let residents, films: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter, climate, gravity, terrain
        case surfaceWater = "surface_water"
        case population, residents, films, created, edited, url
    }
}

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
    case planetURL = "https://swapi.dev/api/planets/1"
    
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
