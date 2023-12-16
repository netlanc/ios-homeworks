import UIKit


class ProfileHeaderView: UIView {
    
    weak var profileVC: profileVCDelegate?
    
    private var statusText: String = ""
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
    }()
    
    private lazy var paddedTextField: TextFieldWithPadding = {
        let paddedTextField = TextFieldWithPadding(frame: CGRect(x: 20, y: 20, width: 200, height: 40))
        paddedTextField.placeholder = "Заполните текст…"
        
        paddedTextField.font = UIFont.systemFont(ofSize: 15)
        
        paddedTextField.backgroundColor = .white
        paddedTextField.layer.cornerRadius = 12
        paddedTextField.layer.borderWidth = 1
        paddedTextField.layer.borderColor = UIColor.black.cgColor
        
        paddedTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return paddedTextField
    }()
    
    private lazy var statusButton: UIButton = {
        let statusButton = UIButton()
        statusButton.setTitle("Set status", for: .normal)
        statusButton.setTitleColor(.white, for: .normal)
        
        statusButton.backgroundColor = .systemBlue
        statusButton.layer.cornerRadius = 4
        statusButton.layer.shadowRadius = 4
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOffset.width = 4
        statusButton.layer.shadowOffset.height = 4
        statusButton.layer.shadowOpacity = 0.7
        statusButton.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        
        return statusButton
    }()
    
    private lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "Loading..."
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.textColor = .gray
        statusLabel.layer.masksToBounds = true
        statusLabel.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return statusLabel
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.text = "Loading..."
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        fullNameLabel.textColor = .black
        fullNameLabel.layer.masksToBounds = true
        fullNameLabel.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return fullNameLabel
    }()
    
    
    var avatarPositionCenter = CGPoint()
    
    private lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
//        let image = UIImage(named: "Grut")
//        avatarImageView.image = image
        
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.masksToBounds = true
        avatarImageView.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let avatarTapOpenGesture = UITapGestureRecognizer(target: self, action: #selector(avatarOpenPreview))
        avatarImageView.addGestureRecognizer(avatarTapOpenGesture)
        avatarImageView.isUserInteractionEnabled = true
        
        return avatarImageView
    }()
    
    private lazy var avatarBgrView: UIView = {
//        let avatarBgrView = UIView()
        let avatarBgrView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        avatarBgrView.backgroundColor = .darkGray
        avatarBgrView.isHidden = true
        avatarBgrView.alpha = 0
        
        avatarBgrView.translatesAutoresizingMaskIntoConstraints = false
        
        return avatarBgrView
    }()
    
    private lazy var avatarCloseButton: UIButton = {
        let avatarCloseButton = UIButton()
        avatarCloseButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        avatarCloseButton.tintColor = .black
        avatarCloseButton.alpha = 0
        
        avatarCloseButton.backgroundColor = .clear
        avatarCloseButton.contentMode = .scaleToFill
        
        avatarCloseButton.addTarget(self, action: #selector(avatarClosePreview), for: .touchUpInside)
        
        avatarCloseButton.translatesAutoresizingMaskIntoConstraints = false
        
        return avatarCloseButton
    }()
    
    @objc func avatarOpenPreview() {

        profileVC?.scrrollStop()
        
        self.avatarPositionCenter = avatarImageView.center
        let scale = UIScreen.main.bounds.width / avatarImageView.bounds.width
        
        UIView.animate(withDuration: 0.5) {
            self.avatarImageView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - self.avatarPositionCenter.y)
            self.avatarImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.avatarImageView.layer.cornerRadius = 0
            self.avatarImageView.layer.borderWidth = 1
            
            self.avatarBgrView.isHidden = false
            self.avatarBgrView.alpha = 0.5
        } completion: { finished in
            UIView.animate(withDuration: 0.3) {
                self.avatarCloseButton.alpha = 1
            }
        }
        
    }
    
    @objc func avatarClosePreview() {
        
        UIImageView.animate(withDuration: 0.3) {
            
            self.avatarCloseButton.alpha = 0
            self.profileVC?.scrrollRun()
            
        } completion: { finished in
            
            UIView.animate(withDuration: 0.5) {
            
                self.avatarImageView.center = self.avatarPositionCenter
                self.avatarImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.width / 2
                self.avatarImageView.layer.borderWidth = 3
                
                self.avatarBgrView.alpha = 0
            }
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tuneHeader()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tuneHeader()
    }
    
    func tuneHeader(){
        
        statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        paddedTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusButton)
        addSubview(paddedTextField)
        
        
        addSubview(avatarBgrView)
        addSubview(avatarCloseButton)
        addSubview(avatarImageView)
        
        addSubview(activityIndicator)
        
        setupContraints()
    }
    
    private func setupContraints() {
        
        let safeAreaGuide = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            avatarImageView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            statusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 26),
            statusButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16),
            statusButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 27),
            fullNameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            
            statusLabel.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -64),
            statusLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            
            paddedTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
            paddedTextField.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16),
            paddedTextField.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            
            avatarCloseButton.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 16),
            avatarCloseButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            
            
            activityIndicator.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            
        ])
        
        activityIndicator.startAnimating()
    }
    
    func configure(with user: User) {
        fullNameLabel.text = user.name
        statusLabel.text = user.status
        avatarImageView.image = user.avatar
    }
    
    @objc func buttonPressed() {
        //print(statusLabel.text ?? "А статус пока не задан")
        
        statusLabel.text = statusText
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
}

