
import UIKit
// Создайте пользовательскую ячейку для отображения фотографий в коллекции
class PhotosCollectionViewCell: UICollectionViewCell {
    static var identifier: String {
        return "PhotosCollectionViewCell"
    }

    
    private enum Constants {
        // Generic layout constants
        static let verticalSpacing: CGFloat = 8.0
        static let horizontalPadding: CGFloat = 16.0
        static let profileDescriptionVerticalPadding: CGFloat = 8.0
        
        // contentView layout constants
        static let contentViewCornerRadius: CGFloat = 4.0

        // profileImageView layout constants
        static let imageHeight: CGFloat = 180.0
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        
        
        // Настройте внешний вид вашей ячейки коллекции, добавьте imageView и установите его констрейнты
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(
        with photo: ProfilePhoto
    ) {
        imageView.image = UIImage(named: photo.image)
    }
}
