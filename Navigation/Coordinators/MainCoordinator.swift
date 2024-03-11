import UIKit

enum AppFlow {
    case profile
    case feed
    case liked
}

class MainCoordinator: MainBaseCoordinator {
    var profileModel: ProfileViewModel
    
    var parentCoordinator: MainBaseCoordinator?
    
    var profileCoordinator: ProfileBaseCoordinator
    var likedCoordinator: LikedCoordinator
    lazy var feedCoordinator: FeedBaseCoordinator = FeedCoordinator()
    //    lazy var loginCoordinator: LogInBaseCoordinator = LoginCoordinator()
    
    lazy var rootViewController: UIViewController = UITabBarController()
    
    init (profileModel: ProfileViewModel){
        self.profileModel = profileModel
        self.profileCoordinator = ProfileCoordinator(profileModel: profileModel)
        self.likedCoordinator = LikedCoordinator(profileModel: profileModel)
    }
    
    func start() -> UIViewController {
        
        let profileViewController = profileCoordinator.start()
        profileCoordinator.parentCoordinator = self
        profileViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("tab.profile", comment: ""),
            image: UIImage(
                systemName: "person"),
            tag: 0
        )
        
        let feedViewController = feedCoordinator.start()
        feedCoordinator.parentCoordinator = self
        feedViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("tab.feed", comment: ""),
            image: UIImage(
                systemName: "note"),
            tag: 1
        )
        
        let likedViewController = likedCoordinator.start()
        likedViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("tab.liked", comment: ""),
            image: UIImage(systemName: "heart"),
            tag: 2
        )
        
        let mapViewController = MapViewController()
        mapViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("tab.map", comment: ""),
            image: UIImage(systemName: "map"),
            tag: 3
        )
        
        (rootViewController as? UITabBarController)?.viewControllers = [profileViewController, feedViewController, likedViewController, mapViewController]
        
        //(rootViewController as? UITabBarController)?.selectedIndex = 3

        return rootViewController
    }
    
    func moveTo(flow: AppFlow) {
        switch flow {
        case .profile:
            (rootViewController as? UITabBarController)?.selectedIndex = 0
        case .feed:
            (rootViewController as? UITabBarController)?.selectedIndex = 1
        case .liked:
            (rootViewController as? UITabBarController)?.selectedIndex = 2
        }
    }
    
    func resetToRoot() -> Self {
        profileCoordinator.resetToRoot()
        moveTo(flow: .profile)
        return self
    }
}

