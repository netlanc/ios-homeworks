import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = { [unowned self] in
        let profileHeaderView = ProfileHeaderView()
        
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        profileHeaderView.backgroundColor = .white
        
        return profileHeaderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(profileHeaderView)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 250),
        
        ])
    }
    
}
