import UIKit

struct ProfilePhoto {
    let name: String
    let image: String
    let date: String
}

extension ProfilePhoto {
    
    static func make() -> [ProfilePhoto] {
        [
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut01",
                date: "22-11-1981"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut02",
                date: "22-11-1981"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut03",
                date: "22-11-1981"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut04",
                date: "22-11-1981"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut05",
                date: "22-11-1981"
            ),
            
            
            
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut06",
                date: "22-11-1981"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut07",
                date: "22-11-1981"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut08",
                date: "22-11-1981"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut09",
                date: "22-11-1981"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut10",
                date: "22-11-1981"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut11",
                date: "22-11-1981"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut12",
                date: "22-11-1981"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut13",
                date: "22-11-1981"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut14",
                date: "22-11-1981"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut01",
                date: "22-11-1981"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut02",
                date: "22-11-1981"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut03",
                date: "22-11-1981"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut04",
                date: "22-11-1981"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut05",
                date: "22-11-1981"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut06",
                date: "22-11-1981"
            ),
        ]
    }
}

var profilePhotos: [ProfilePhoto] = ProfilePhoto.make()
