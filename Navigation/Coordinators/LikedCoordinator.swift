//
//  LikedCoordinator.swift
//  Navigation
//
//  Created by netlanc on 22.02.2024.
//

import UIKit

class LikedCoordinator: LikedBaseCoordinator {
    
    var profileModel: ProfileViewModel
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    init (profileModel: ProfileViewModel){
        self.profileModel = profileModel
    }
    
    func start() -> UIViewController {
        let likedViewController = LikedPostsViewController(profileViewModel: profileModel)
        likedViewController.view.backgroundColor = .systemBackground
        return UINavigationController(rootViewController: likedViewController)
    }
    
    func showLikedScreen() {
        
    }
}
