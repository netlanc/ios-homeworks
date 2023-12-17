import UIKit

class ProfileCoordinator: Coordinator {
    var navigationController: UINavigationController!
    var tabBarController: UITabBarController

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        self.navigationController = UINavigationController()
    }

    func start() {
        
        let viewProfileModel = ProfileViewModel()
        viewProfileModel.changeStateIfNeeded()
        
        let profileViewController = ProfileViewController(viewModel: viewProfileModel)
        profileViewController.title = "Профиль"
        profileViewController.view.backgroundColor = .lightGray
        profileViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: 0)

        navigationController.pushViewController(profileViewController, animated: false)
    }
}
