import UIKit

struct ProfilePhoto {
    let name: String
    let image: String
}

extension ProfilePhoto {
    
    static func makeImages() -> [UIImage] {
        
        let photos = self.make()
        
        var photosImages: [UIImage] = []
        
        for photo in photos {
            if let image = UIImage(named: photo.image) {
                photosImages.append(image)
            }
        }
        
        return photosImages
    }
    
    static func make() -> [ProfilePhoto] {
        [
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut01"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut02"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut03"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut04"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut05"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut06"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut07"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut08"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut09"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut10"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut11"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut12"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut13"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut14"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut01"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut02"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut03"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut04"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut05"
            ),
            ProfilePhoto(
                name: "Я есть грут",
                image: "Grut06"
            ),
        ]
    }
}

var profilePhotos: [ProfilePhoto] = ProfilePhoto.make()
