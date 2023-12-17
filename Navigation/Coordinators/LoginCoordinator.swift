import UIKit

class LoginCoordinator: Coordinator {
    var navigationController: UINavigationController!
    var tabBarController: UITabBarController

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        self.navigationController = UINavigationController()
    }

    func start() {
        let loginViewController = LogInViewController()
        loginViewController.view.backgroundColor = .systemBackground
        
        let loginInspector = MyLoginFactory().makeLoginInspector()
        loginViewController.loginDelegate = loginInspector
        
        loginViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: 2)

        navigationController.pushViewController(loginViewController, animated: false)
    }
}
