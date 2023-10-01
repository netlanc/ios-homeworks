import UIKit

class ProfileViewController: UIViewController {
    
    
    private lazy var profileHeaderView: ProfileHeaderView = { [unowned self] in
        let profileHeaderView = ProfileHeaderView()
        
        return profileHeaderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(profileHeaderView)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
//        profileHeaderView.frame.size = view.frame.size
        profileHeaderView.frame.size.height = 200
        
        profileHeaderView.frame = view.bounds
    }
    
}
