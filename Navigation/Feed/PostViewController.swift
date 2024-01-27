import UIKit
import StorageService

struct PostButton {
    let title: String
}

class PostViewController: UIViewController {
    
    var post: Post?
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .black
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    private lazy var infoButton: CustomButton = {
        let infoButton = CustomButton("Показать данные", .white, .systemBlue, tapButton: { [weak self] in
                self?.infoBarButtonTapped()
            }
        )
        
        return infoButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInfoBarButton()
        // передаем в title страницы текст заголовка
        title = "Пост"
        
        view.backgroundColor = .systemGray

        titleLabel.text = post?.title
        
        view.addSubview(titleLabel)
        view.addSubview(infoButton)
        
        setupConstraint()
        
    }
    
    private func setupConstraint() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12),
            
            infoButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            infoButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            infoButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])
    }
    
    // создает кнопку и помещает ее в rightBarButtonы
    private func configureInfoBarButton() {
        
        
        //print("ololo")
        //navigationItem.title = "Сегодня"
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(infoBarButtonTapped))
        //navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.6906365752, green: 0, blue: 0.8297687173, alpha: 1)
        
    }
    
    // создает модальное окно из InfoViewController и показывает его
    @objc private func infoBarButtonTapped() {
        let infoViewController = InfoViewController()
        infoViewController.view.backgroundColor = .systemYellow
        
        let navigationController = UINavigationController(rootViewController: infoViewController)
        
        navigationController.modalTransitionStyle = .coverVertical
        navigationController.modalPresentationStyle = .popover
        
        present(navigationController, animated: true, completion: nil)
    }
}
