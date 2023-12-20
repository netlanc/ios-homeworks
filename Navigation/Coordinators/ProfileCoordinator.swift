import UIKit

class ProfileCoordinator: ProfileBaseCoordinator {

    
    var parentCoordinator: MainBaseCoordinator?
    lazy var rootViewController: UIViewController = UIViewController()
    lazy var profileModel: ProfileViewModel = ProfileViewModel()
    
    func start() -> UIViewController {
    
        profileModel.showProfile = { [weak self] in
            self?.showProfileScreen()
        }
        profileModel.showGallery = { [weak self] in
            self?.showGalleryScreen()
        }
        
        let loginViewController = LogInViewController(profileModel: profileModel)
        loginViewController.view.backgroundColor = .systemBackground
        
        let loginInspector = MyLoginFactory().makeLoginInspector()
        loginViewController.loginDelegate = loginInspector
        rootViewController = UINavigationController(
            rootViewController: loginViewController
        )
        
        return rootViewController
    }
    
    func showProfileScreen() {
        let profileViewController = ProfileViewController(
            viewModel: profileModel
        )

        navigationRootViewController?.pushViewController(profileViewController, animated: true)
    }
    
    func showGalleryScreen() {
        
        let galleryVC = GalleryViewController()
        //galleryVC.galleryPhotos = profilePhotos
        
        let backBtn = UIBarButtonItem()
        backBtn.title = "Назад"
        navigationRootViewController?.navigationItem.backBarButtonItem = backBtn
        
        navigationRootViewController?.pushViewController(galleryVC, animated: true)
    }
}

