import UIKit


class ProfileHeaderView: UIView {
    
    private let statusButton: UIButton = {
        let statusButton = UIButton()
        statusButton.setTitle("Show status", for: .normal)
        statusButton.setTitleColor(.white, for: .normal)
        
        statusButton.backgroundColor = .systemBlue
        statusButton.layer.cornerRadius = 4
        statusButton.layer.shadowRadius = 4
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOffset.width = 4
        statusButton.layer.shadowOffset.height = 4
        statusButton.layer.shadowOpacity = 0.7
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        
        return statusButton
    }()
    
    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "Я есть Грут...Я есть Грут...Я есть Грут...Я есть..."
        statusLabel.font = UIFont(name:"HelveticaNeue", size: 16.0)
        statusLabel.textColor = .gray
        statusLabel.layer.masksToBounds = true
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return statusLabel
    }()
    
    private let fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.text = "Я есть Грут"
        fullNameLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        fullNameLabel.textColor = .black
        fullNameLabel.layer.masksToBounds = true
        
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return fullNameLabel
    }()
    
    private let avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        let image = UIImage(named: "Grut")
        avatarImageView.image = image
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.layer.cornerRadius = 75
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.masksToBounds = true
        
        return avatarImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        
        statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusButton)
        
        setupContraints()
        //        self.backgroundColor = .red
        
        //        addSubview(imageView)
    }
    
    
    
    private func setupContraints() {
        
        let safeAreaGuide = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            avatarImageView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 150),
            avatarImageView.heightAnchor.constraint(equalToConstant: 150),
            
            statusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            statusButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16),
            statusButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 27),
            fullNameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            
            statusLabel.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -34),
            statusLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16)
            
        ])
    }
    
    @objc func buttonPressed() {
        print(statusLabel.text ?? "А статус пока не задан")
    }
}
