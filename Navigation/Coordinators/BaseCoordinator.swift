import UIKit

typealias Action = (() -> Void)

protocol FlowCoordinator: AnyObject {
    var parentCoordinator: MainBaseCoordinator? { get set }
}

protocol Coordinator: FlowCoordinator {
    var rootViewController: UIViewController { get set }
    func start() -> UIViewController
    @discardableResult func resetToRoot() -> Self
}

extension Coordinator {
    var navigationRootViewController: UINavigationController? {
        get {
            (rootViewController as? UINavigationController)
        }
    }
    
    func resetToRoot() -> Self {
        navigationRootViewController?.popToRootViewController(animated: false)
        return self
    }
}

protocol ProfileBaseCoordinator: Coordinator {
    func showProfileScreen()
    func showGalleryScreen()
}

protocol FeedBaseCoordinator: Coordinator {
    func showDetailScreen()
}

protocol MainBaseCoordinator: Coordinator {
    var profileCoordinator: ProfileBaseCoordinator { get }
    var feedCoordinator: FeedBaseCoordinator { get }
    func moveTo(flow: AppFlow)
}


