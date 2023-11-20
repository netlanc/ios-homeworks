import UIKit

struct PostButton {
    let title: String
}

class PostViewController: UIViewController {
    
    var post: PostButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        // передаем в title страницы текст заголовка
        self.title = post?.title
        
        self.view.backgroundColor = .systemBackground

        configureInfoBarButton()
    }
    
    // создает кнопку и помещает ее в rightBarButtonы
    private func configureInfoBarButton() {
        let infoBarButton = UIBarButtonItem(title: "Инфо", style: .plain, target: self, action: #selector(infoBarButtonTapped))
        navigationItem.rightBarButtonItem = infoBarButton
    }
    
    // создает модальное окно из InfoViewController и показывает его
    @objc private func infoBarButtonTapped() {
        let infoViewController = InfoViewController()
        let navigationController = UINavigationController(rootViewController: infoViewController)
        
        navigationController.view.backgroundColor = .systemYellow
        navigationController.modalTransitionStyle = .flipHorizontal
        navigationController.modalPresentationStyle = .popover
        
        present(navigationController, animated: true, completion: nil)
    }
}
