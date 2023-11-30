import UIKit
import SnapKit

class PhotosTableViewCell: UITableViewCell {
    
    var photos: [ProfilePhoto] = ProfilePhoto.make()
    
    private lazy var collectionView: UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    private let titleView: UIView = {
        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Фото"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let disclosureIndicator: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right")?.withTintColor(.black, renderingMode: .alwaysOriginal))
        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        tuneCell()
        setupContraints()
    
    }
    
    private func tuneCell() {
        
        titleView.addSubview(titleLabel)
        titleView.addSubview(disclosureIndicator)
        contentView.addSubview(titleView)
        contentView.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(PhotosCollectionViewCell.self,forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
    }
    
    private func setupContraints() {
        
//        NSLayoutConstraint.activate([
//            titleView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            titleView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: 0),
//            
//            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 12),
//            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -12),
//            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 12),
//            
//            disclosureIndicator.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 12),
//            disclosureIndicator.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -12),
//            disclosureIndicator.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -12),
//
//            collectionView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 12),
//            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
//            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
//            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
//            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 1.0 / 4)
//        ])
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(collectionView.snp.top)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.top).offset(12)
            make.bottom.equalTo(titleView.snp.bottom).offset(-12)
            make.leading.equalTo(titleView.snp.leading).offset(12)
        }
        
        disclosureIndicator.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.top).offset(12)
            make.bottom.equalTo(titleView.snp.bottom).offset(-12)
            make.trailing.equalTo(titleView.snp.trailing).offset(-12)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(12)
            make.bottom.equalTo(contentView.snp.bottom).offset(-12)
            make.leading.equalTo(contentView.snp.leading).offset(12)
            make.trailing.equalTo(contentView.snp.trailing).offset(-12)
            make.height.equalTo(collectionView.snp.width).multipliedBy(1.0 / 4)
        }

        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PhotosTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(4, photos.count)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        
        let photo = photos[indexPath.row]
        
        cell.imageView.image = UIImage(named: photo.image)
        return cell
    }
}

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = collectionView.bounds.width
        let itemWidth = (screenWidth - 32) / 4
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

