import UIKit

class FeedCoordinator: Coordinator {
    var navigationController: UINavigationController!
    var tabBarController: UITabBarController

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        self.navigationController = UINavigationController()
    }

    func start() {
        let feedViewController = FeedViewController()
        feedViewController.title = "Лента"
        feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "note"), tag: 1)

        navigationController.pushViewController(feedViewController, animated: false)
    }
}
