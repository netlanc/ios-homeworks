import UIKit

class AppCoordinator: Coordinator {
    var window: UIWindow?
    var tabBarController: UITabBarController!

    init(window: UIWindow?) {
        self.window = window
    }

    func start() {
        tabBarController = UITabBarController()
        
        let loginCoordinator = LoginCoordinator(tabBarController: tabBarController)
        let feedCoordinator = FeedCoordinator(tabBarController: tabBarController)
//        let profileCoordinator = ProfileCoordinator(tabBarController: tabBarController)
        
        loginCoordinator.start()
        feedCoordinator.start()
//        profileCoordinator.start()

        let controllers: [UIViewController] = [
            loginCoordinator.navigationController,
            feedCoordinator.navigationController,
//            profileCoordinator.navigationController
        ]
        tabBarController.viewControllers = controllers

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
