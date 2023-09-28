import UIKit

class FeedViewController: UIViewController {
    
    let post = Post(title: "Заголовок поста")
    
    // создание кнопки "Показать пост"
    private var showPostButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Показать пост", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // добавлени кнопке обработчика по нажатию
    fileprivate func configureShowPostButton() {
        showPostButton.addTarget(self, action: #selector(showPostButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Лента"
        self.view.backgroundColor = .systemOrange

        configureShowPostButton()
        setupShowPostButton()
    }
    
    private func setupShowPostButton() {
        self.view.addSubview(showPostButton)
        
        NSLayoutConstraint.activate([
            showPostButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            showPostButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
    @objc private func showPostButtonTapped() {
        let postViewController = PostViewController()
        postViewController.post = post
        self.navigationController?.pushViewController(postViewController, animated: true)
    }

}

