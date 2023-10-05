import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = { [unowned self] in
        let profileHeaderView = ProfileHeaderView()
        
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        profileHeaderView.backgroundColor = .white
        
        return profileHeaderView
    }()
    
    private lazy var titleButton: UIButton = {
        
        let titleButton = UIButton()
        titleButton.setTitle("Set title", for: .normal)
        titleButton.setTitleColor(.white, for: .normal)
        
        titleButton.backgroundColor = .systemRed
        titleButton.layer.cornerRadius = 4
        titleButton.layer.shadowRadius = 4
        titleButton.layer.shadowColor = UIColor.black.cgColor
        titleButton.layer.shadowOffset.width = 4
        titleButton.layer.shadowOffset.height = 4
        titleButton.layer.shadowOpacity = 0.7
        titleButton.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        
        titleButton.translatesAutoresizingMaskIntoConstraints = false
        
        return titleButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(profileHeaderView)
        view.addSubview(titleButton)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            
            titleButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            titleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleButton.heightAnchor.constraint(equalToConstant: 50),
        
        ])
    }
    
}
