import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        
        
        let loginViewController = LogInViewController()
        loginViewController.title = "Логин"
//        loginViewController.navigationBar.isHidden = true
        loginViewController.view.backgroundColor = .systemBackground
        
        let feedViewController = FeedViewController()
        feedViewController.title = "Лента"
        feedViewController.view.backgroundColor = .systemOrange
        
        let profileViewController = ProfileViewController()
        profileViewController.title = "Профиль"
        profileViewController.view.backgroundColor = .lightGray
        
        let tabBarController = UITabBarController()
        
        loginViewController.tabBarItem = UITabBarItem(title: "Логин", image: UIImage(systemName: "person.crop.circle"), tag: 0)
        feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "note"), tag: 1)
        profileViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: 2)
        
        let controllers = [
            loginViewController,
            feedViewController,
//            profileViewController
        ]
        tabBarController.viewControllers = controllers.map {
            let navController = UINavigationController(rootViewController: $0)
            navController.navigationBar.isHidden = true
            return navController
        }
        tabBarController.selectedIndex = 0
        
        window.rootViewController = tabBarController
        
        window.makeKeyAndVisible()
        
        self.window = window
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

