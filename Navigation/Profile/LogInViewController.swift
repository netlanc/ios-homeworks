import UIKit

class LogInViewController: UIViewController {
    
    private lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView(frame:CGRect(x: 0, y: 0, width: 100, height: 100))
        let image = UIImage(named: "LogoVK")
        logoImageView.image = image
        
//        logoImageView.layer.cornerRadius = 10
//        logoImageView.layer.borderWidth = 0.5
//        logoImageView.layer.borderColor = UIColor.lightGray.cgColor
        logoImageView.layer.masksToBounds = true
        logoImageView.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return logoImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(logoImageView)
        
        setupContraints()
    }
    
    private func setupContraints() {
        
        let safeAreaGuide = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            logoImageView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 120),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
        ])
        
    }
    
}
