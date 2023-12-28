import UIKit
import iOSIntPackage

class GalleryViewController: UIViewController {
    
    var imageProcessor = ImageProcessor()
    
//    var imageFacade = ImagePublisherFacade()
//    var galleryImages: [UIImage] = []
    
    var galleryPhotos = ProfilePhoto.makeImages()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        
        collectionView.register(
            GalleryCollectionViewCell.self,
            forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier
        )
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .white
        title = "Фото галерея"
    
        collectionView.delegate = self
        collectionView.dataSource = self

        view.addSubview(collectionView)
        setupConstraints()
        
        runProcessImagesOnThread()
        
//        imageFacade.subscribe(self)
//        imageFacade.addImagesWithTimer(time: 0.5, repeat: 20, userImages: galleryPhotos)
    }

    func runProcessImagesOnThread() {
        
        let dateBegin = Date()
        
        let colorFilter: ColorFilter = .noir
        let qualityOfService: QualityOfService = .default
        
        imageProcessor.processImagesOnThread(sourceImages: galleryPhotos, filter: colorFilter, qos: qualityOfService) { [weak self] photos in
            
                self?.galleryPhotos = photos.compactMap{ $0 }.map{ UIImage(cgImage: $0)}
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                
                let dateEnd = Date().timeIntervalSince(dateBegin)
                print("Время обработки \(photos.count) фото с фильтром \"\(colorFilter)\" и QOS \"\(qualityOfService.rawValue)\" - \(dateEnd) секунд")
            }
    }

    func setupConstraints() {
      
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.setNavigationBarHidden(false, animated: animated)
       
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        imageFacade.removeSubscription(for: self)
//    }
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 8.0
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
//        galleryImages.count
        galleryPhotos.count

    }

    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier,for: indexPath) as! GalleryCollectionViewCell
        
//        let image = galleryImages[indexPath.row]
//        cell.setup(with: image)
        
        let photo = galleryPhotos[indexPath.row]
        cell.setup(with: photo)
        
        return cell
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    
    private func itemWidth(for width: CGFloat,spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 3
        
        let totalSpacing: CGFloat = 3 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        
        return floor(finalWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(
            for: view.frame.width,
            spacing: LayoutConstant.spacing
        )
        
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(
            top: LayoutConstant.spacing,
            left: LayoutConstant.spacing,
            bottom: LayoutConstant.spacing,
            right: LayoutConstant.spacing
        )
    }

    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        LayoutConstant.spacing
    }

    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        LayoutConstant.spacing
    }
    
    func collectionView(
_ collectionView: UICollectionView,willDisplay cell: UICollectionViewCell,forItemAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = .white
    }
    
}

//extension GalleryViewController: ImageLibrarySubscriber {
//    func receive(images: [UIImage]) {
//        galleryImages = images
//        collectionView.reloadData()
//    }
//}
