import UIKit

class ProfileCoordinator: ProfileBaseCoordinator {

    var profileModel: ProfileViewModel
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    init (profileModel: ProfileViewModel){
        self.profileModel = profileModel
    }
    
    func start() -> UIViewController {
    
        profileModel.showProfile = { [weak self] in
            self?.showProfileScreen()
        }
        profileModel.showGallery = { [weak self] in
            self?.showGalleryScreen()
        }
        
        let checkerService = CheckerService()
        let loginInspector = MyLoginFactory(checkerService: checkerService).makeLoginInspector()
        
        let loginViewController = LogInViewController(profileModel: profileModel, loginInspector: loginInspector)
        loginViewController.view.backgroundColor = .systemBackground
        
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
        backBtn.title = NSLocalizedString("nav.back", comment: "")
        navigationRootViewController?.navigationItem.backBarButtonItem = backBtn
        
        navigationRootViewController?.pushViewController(galleryVC, animated: true)
    }
}

