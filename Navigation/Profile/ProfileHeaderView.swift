import UIKit

class ProfileHeaderView: UIView {
    
    private var statusText: String = ""
    
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
        statusLabel.text = "Я есть Грут...Я есть Грут...Я есть Грут...Я есть..."
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.textColor = .gray
        statusLabel.layer.masksToBounds = true
        statusLabel.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return statusLabel
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.text = "Я есть Грут"
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        fullNameLabel.textColor = .black
        fullNameLabel.layer.masksToBounds = true
        fullNameLabel.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return fullNameLabel
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        let image = UIImage(named: "Grut")
        avatarImageView.image = image
        
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.masksToBounds = true
        avatarImageView.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return avatarImageView
    }()
    
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
        
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusButton)
        addSubview(paddedTextField)
        
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
            paddedTextField.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16)
            
        ])
    }
    
    @objc func buttonPressed() {
        //print(statusLabel.text ?? "А статус пока не задан")
        
        statusLabel.text = statusText
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
}

