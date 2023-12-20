import UIKit


class FeedCoordinator: FeedBaseCoordinator {
    
    var parentCoordinator: MainBaseCoordinator?
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        
        let feedViewController = FeedViewController()
//        feedViewController.title = "Лента"
//        feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "note"), tag: 1)
        
        rootViewController = UINavigationController(
            rootViewController: feedViewController
        )
        return rootViewController
    }
    
    func showDetailScreen() {
//        let vc = OrdersDetailVC()
//        navigationRootViewController?.pushViewController(vc, animated: true)
    }
}
