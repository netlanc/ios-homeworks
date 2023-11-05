import UIKit

final class TableViewCell: UITableViewCell {
        
    static let reuseIdentifier = "TableViewCell"
    
    var photos: [ProfilePhoto] = ProfilePhoto.make()
    
    /// Value that determines the number of squares to display in the UICollectionView.
    private var numberOfSquares = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Фото"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let disclosureIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupCollectionView()
        self.setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupUI() {
        
        
        titleView.addSubview(self.titleLabel)
        titleView.addSubview(self.disclosureIndicator)
        contentView.addSubview(titleView)
        
        contentView.addSubview(collectionView)
        
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 48),
            
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 12),
            
            disclosureIndicator.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            disclosureIndicator.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -12),
            disclosureIndicator.heightAnchor.constraint(equalToConstant: 24),
            disclosureIndicator.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
//            collectionView.heightAnchor.constraint(equalToConstant: 86.25),
            collectionView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
//            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Data source update
    
    /// Updates the `numberOfSquares` property
    func update() {
        numberOfSquares = min(4, photos.count)
        
        print("uddate")
        
//        collectionView.contentSize.height += titleView.frame.height
        collectionView.reloadData()
    }
    
    // MARK: - Workaround
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        contentView.frame = self.bounds
        contentView.layoutIfNeeded()
        
        return collectionView.contentSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // При изменении ориентации экрана, пересчитайте размеры изображений в ячейках
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = (collectionView.frame.width - 48.0) / 4
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
            
            collectionView.reloadData()
        }
    }


}

// MARK: - UICollectionViewDataSource

extension TableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return min(4, photos.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        let photo = photos[indexPath.row]
        cell.setup(photo, cell.bounds.width)
        
        return cell
    }
}

extension TableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - 48.0) / 4
        print("screenWidth ", screenWidth)
        print("itemWidth ", itemWidth)
        
        return CGSize(width: itemWidth, height: itemWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    
}
