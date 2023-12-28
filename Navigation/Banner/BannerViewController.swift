import UIKit

class BannerViewController: UIViewController {
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.alpha = 1
        
        button.backgroundColor = .clear
        button.contentMode = .scaleToFill
        
        button.addTarget(self, action: #selector(closeBanner), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleText: UILabel = {
        let titleText = UILabel()
        titleText.font = UIFont.italicSystemFont(ofSize: 27)
        
        titleText.text = "С рождеством и новым годом поздравляет..."
        
        titleText.textColor = .white
        titleText.numberOfLines = 0
        
        titleText.translatesAutoresizingMaskIntoConstraints = false
        
        return titleText
    }()
    
    private lazy var nameText: UILabel = {
        let nameText = UILabel()
//        titleText.font = UIFont.systemFont(ofSize: 18)
        nameText.font = UIFont.italicSystemFont(ofSize: 50)
        
        nameText.text = "Я есть грут"
        
        nameText.textColor = .white
        nameText.numberOfLines = 0
        
        nameText.translatesAutoresizingMaskIntoConstraints = false
        
        return nameText
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(backgroundImageView)
        view.addSubview(titleText)
        view.addSubview(nameText)
        view.addSubview(closeButton)
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            titleText.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            titleText.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor),
            titleText.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            titleText.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16),
            
            nameText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 26),
            nameText.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            
            closeButton.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
        ])
        backgroundImageView.image = UIImage(named: "banner")
        
    }
    
    @objc func closeBanner() {
        dismiss(animated: true)
    }
}
